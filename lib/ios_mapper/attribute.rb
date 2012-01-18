module IosMapper
  class Attribute
    
    COLUMN_MAPPING = {
      :integer => 'NSNumber',
      :string => 'NSString',
      :text => 'NSString',
      :datetime => 'NSDate',
      :date => 'NSDate',
      :float => 'NSDecimalNumber',
      :boolean => 'BOOL'
    }
    
    COLUMN_RETAIN = {
      :integer => 'retain',
      :string => 'retain',
      :text => 'retain',
      :datetime => 'retain',
      :date => 'retain',
      :float => 'retain',
      :boolean => 'assign'
    }
    
    attr_accessor :type, :name, :retain
    
    def self.key_field(klass)
      attribute = self.new
      attribute.type = :integer
      attribute.name = "#{klass.to_s.underscore}_id"
      attribute
    end
    
    def initialize(column = nil)
      @column = column
    end
    
    def variable_type
      COLUMN_MAPPING[@type] || COLUMN_MAPPING[@column.type]
    end
    
    def variable_name
      @name || @column.name
    end
    
    def retain_type
      @retain || COLUMN_RETAIN[@type] || COLUMN_RETAIN[@column.type]
    end
    
    def to_mapping_key
      "@\"#{variable_name}\""
    end
    
    def to_ios_property
      Property.new(retain_type, variable_type, variable_name).render_property
    end
    
    def to_dealloc_line
      Property.new(retain_type, variable_type, variable_name).render_dealloc
    end

  end
end

