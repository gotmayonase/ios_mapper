require 'erb'
module IosMapper
  class Mapper
  
    def initialize(klass, user_name=`whoami`.chomp)
      @klass = klass
      @properties = _map_columns + _associations
      @associations = _associations
      @attachments = _paperclip_attachments
      @user_name = user_name
    end
  
    def get_binding
      binding
    end
  
    def to_model_header_file
      erb = ERB.new(File.read(File.expand_path(__FILE__) + 'templates/model_header.txt.erb'), 0, '>')
      erb.result(binding)
    end
  
    def to_model_implementation_file
      erb = ERB.new(File.read(File.expand_path(__FILE__) + 'templates/model_implementation.txt.erb'), 0, '>')
      erb.result(binding)
    end
    
    def to_service_header_file
      erb = ERB.new(File.read(File.expand_path(__FILE__) + 'templates/service_header.txt.erb'), 0, '>')
      erb.result(binding)
    end
  
    def to_service_implementation_file
      erb = ERB.new(File.read(File.expand_path(__FILE__) + 'templates/service_implementation.txt.erb'), 0, '>')
      erb.result(binding)
    end

    private
  
      def _map_columns
        columns = @klass.columns
        regex_string = "^id$"
        regex_string << ('|' + _paperclip_attachments.join('|')) unless _paperclip_attachments.blank?
        columns.reject! { |c| c.name =~ /#{regex_string}/ }
        columns.map! { |c| Attribute.new(c) }
        columns.unshift( Attribute.key_field(@klass) )
        columns
      end
  
      def _associations
        reflections = @klass.reflect_on_all_associations
        # gather has_many :through associations
        associations = reflections.select { |a| a.macro == :has_many && a.options[:through] }.map do |a|
          # delete :through portion
          reflections.delete_if { |h| h.name == a.options[:through] }
          # remove this one, we're done with it after this
          reflections.delete(a)
          # map to an association
          Association.setup(a)
        end
        # map the rest to Association objects
        associations + reflections.map { |r| Association.setup(r) }
      end

      def _paperclip_attachments
        @klass.attachment_definitions ? @klass.attachment_definitions.keys.map { |a| Attachment.new(a) } : []
      end
      
  end
end