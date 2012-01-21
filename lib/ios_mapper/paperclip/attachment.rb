module IosMapper
  class Attachment
    
    def initialize(attachment)
      @attachment = attachment
      @properties = [
        Property.new('retain','NSData', "#{@attachment}_data"),
        Property.new('retain','NSString',"#{@attachment}_url")
      ]
    end
    
    def to_ios_property
      @properties.map(&:render_property).join("\n")
    end
    
    def synthesize_name
      "#{@attachment}_data, #{@attachment}_url"
    end
    
    def to_dealloc_line
      @properties.map(&:render_dealloc).join("\n")
    end
    
    def to_mapping_key
      "@\"#{@attachment}_url\""
    end
    
  end
  
end