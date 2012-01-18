module IosMapper
  class Association
    
    def self.setup(association)
      "IosMapper::#{association.macro.to_s.classify}Association".constantize.new(association)
    end
    
    def initialize(association)
      @association = association
    end
    
    def variable_type
      'NSArray'
    end
    
    def variable_name
      @association.class_name.downcase.pluralize
    end
    
    def retain_type
      'retain'
    end
    
    def to_ios_import
      "#import \"#{@association.class_name}.h\""
    end
    
    def to_mapping_key
      nil
    end
    
    def to_ios_property
      Property.new(retain_type, variable_type, variable_name).render_property
    end
    
    def to_dealloc_line
      Property.new(retain_type, variable_type, variable_name).render_dealloc
    end
    
  end
  
  class BelongsToAssociation < Association
    def variable_type
      @association.class_name
    end
    
    def variable_name
      @association.class_name.downcase
    end
    
    def to_ios_property
      "#{Property.new(retain_type, 'NSNumber', @association.foreign_key).render_property}\n#{super}"
    end
    
    def to_dealloc_line
      "#{Property.new(retain_type, 'NSNumber', @association.foreign_key).render_dealloc}\n#{super}"
    end
  end
  
  class HasManyAssociation < Association
  end
  
  class HasManyThroughAssociation < Association    
  end
  
  class HasAndBelongsToManyAssociation < Association
  end
end