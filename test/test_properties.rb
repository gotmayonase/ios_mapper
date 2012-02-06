require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/ios_mapper'))

class TestProperties < MiniTest::Unit::TestCase
  
  def setup
    @property = IosMapper::Property.new('retain', 'NSInteger', 'my_test_int')
  end
  
  def test_render_retained_property
    assert_equal "@property (nonatomic, retain) NSInteger *my_test_int;", @property.render_property
  end
  
  def test_render_non_retained_property
    @property.retain_type = 'strong'
    assert_equal "@property (nonatomic, strong) NSInteger my_test_int;", @property.render_property
  end
  
  def test_render_retained_property_dealloc
    assert_equal "self.my_test_int = nil;", @property.render_dealloc
  end
  
  def test_render_non_retained_property_dealloc
    @property.retain_type = 'strong'
    assert_equal "self.my_test_int = nil;", @property.render_dealloc
  end
  
end