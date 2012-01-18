require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/ios_mapper'))

class TestAttributes < MiniTest::Unit::TestCase
  
  def setup
    @column = MiniTest::Mock.new
    @attribute = IosMapper::Attribute.new(@column)
  end
  
  def test_integer_generates_retained_nsnumber_property
    @column.expect :type, :integer
    @column.expect :name, 'my_test_int'
    assert_equal '@property (nonatomic, retain) NSNumber *my_test_int;', @attribute.to_ios_property
  end
  
  def test_string_generates_retained_nsstring_property
    @column.expect :type, :string
    @column.expect :name, 'my_test_string'
    assert_equal '@property (nonatomic, retain) NSString *my_test_string;', @attribute.to_ios_property
  end
  
  def test_text_generates_retained_nsstring_property
    @column.expect :type, :text
    @column.expect :name, 'my_test_text'
    assert_equal '@property (nonatomic, retain) NSString *my_test_text;', @attribute.to_ios_property
  end
  
  def test_datetime_generates_retained_nsdate_property
    @column.expect :type, :datetime
    @column.expect :name, 'my_test_datetime'
    assert_equal '@property (nonatomic, retain) NSDate *my_test_datetime;', @attribute.to_ios_property
  end
  
  def test_date_generates_retained_nsdate_property
    @column.expect :type, :date
    @column.expect :name, 'my_test_date'
    assert_equal '@property (nonatomic, retain) NSDate *my_test_date;', @attribute.to_ios_property
  end
  
  def test_float_generates_retained_nsdecimalnumber_property
    @column.expect :type, :float
    @column.expect :name, 'my_test_float'
    assert_equal '@property (nonatomic, retain) NSDecimalNumber *my_test_float;', @attribute.to_ios_property
  end
  
  def test_boolean_generates_assign_bool_property
    @column.expect :type, :boolean
    @column.expect :name, 'my_test_boolean'
    assert_equal '@property (nonatomic, assign) BOOL my_test_boolean;', @attribute.to_ios_property
  end
  
  def test_key_field_for_klass
    assert_equal '@property (nonatomic, retain) NSNumber *test_attributes_id;', IosMapper::Attribute.key_field(self.class).to_ios_property
  end
  
  def test_mapping_key
    @column.expect :name, 'my_test_column'
    assert_equal '@"my_test_column"', @attribute.to_mapping_key
  end
  
  def test_dealloc_line
    @column.expect :name, 'my_test_column'
    @column.expect :type, :integer
    assert_equal 'self.my_test_column = nil;', @attribute.to_dealloc_line
  end
  
end