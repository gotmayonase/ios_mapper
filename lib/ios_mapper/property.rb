module IosMapper
  class Property
    PROPERTY_TEMPLATE = File.read(File.dirname(__FILE__) + '/templates/property.txt.erb')
    DEALLOC_TEMPLATE = File.read(File.dirname(__FILE__) + '/templates/dealloc.txt.erb')
    attr_accessor :retain_type, :variable_type, :variable_name
    
    def initialize(retain_type, variable_type, variable_name)
      @retain_type, @variable_type, @variable_name = retain_type, variable_type, variable_name
    end
    
    def render_property
      erb = ERB.new(PROPERTY_TEMPLATE, 0, '>')
      erb.result(binding)
    end
    
    def synthesize_name
      variable_name
    end
    
    def render_dealloc
      erb = ERB.new(DEALLOC_TEMPLATE, 0, '>')
      erb.result(binding)
    end
    
  end
end