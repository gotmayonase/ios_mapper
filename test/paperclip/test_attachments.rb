require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '../../lib/ios_mapper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../../lib/ios_mapper/paperclip'))

class TestAttachments < MiniTest::Unit::TestCase
  
  def setup
    @attachment = IosMapper::Attachment.new(:image)
  end
  
  def test_to_ios_property
    assert_equal "@property (nonatomic, retain) NSData *image_data;\n@property (nonatomic, retain) NSString *image_url;", @attachment.to_ios_property
  end
  
  def test_to_dealloc_line
    assert_equal "self.image_data = nil;\nself.image_url = nil;", @attachment.to_dealloc_line
  end
  
  def test_to_mapping_key
    assert_equal "@\"image_url\"", @attachment.to_mapping_key
  end
  
  def test_synthesize_name
    assert_equal "image_data, image_url", @attachment.synthesize_name
  end
  
end