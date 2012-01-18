module IosMapper
  class Attachment
    
    def initialize(attachment)
      @attachment = attachment
    end
    
    def to_property
      <<-PROPERTY
@property (nonatomic, retain) NSData *#{@attachment}_data;
@property (nonatomic, retain) NSString *#{@attachment}_url;
      PROPERTY
    end
    
    def synthesize_name
      "#{@attachment}_data, #{@attachment}_url"
    end
    
    def to_dealloc_line
      <<-PROPERTY
self.#{@attachment}_data = nil;
self.#{@attachment}_url = nil;
      PROPERTY
    end
    
    def to_mapping_key
      "@\"#{@attachment}_url\""
    end
    
  end
  
end