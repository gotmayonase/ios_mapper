module IosMapper
  module RestKit
    module Association
      MAPPING_TEMPLATE = File.read(File.join(File.dirname(__FILE__), '../templates/rest_kit/mapping.txt.erb'))
      
      def to_rest_kit_mapping
        erb = ERB.new(MAPPING_TEMPLATE, 0, '>')
        erb.result(binding)
      end
      
    end
  end
end