require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '../../lib/ios_mapper'))
require File.expand_path(File.join(File.dirname(__FILE__), '../../lib/ios_mapper/rest_kit'))


class TestRestKitAssociations < MiniTest::Unit::TestCase
  
  def test_rest_kit_mapping
    @rails_association = MiniTest::Mock.new
    @rails_association.expect :class_name, 'Association'
    @rails_association.expect :macro, :belongs_to
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal "RKObjectRelationshipMapping *associationMap = [RKObjectRelationshipMapping mappingFromKeyPath:@\"association\" toKeyPath:@\"association\" withMapping:[Association objectMapping]];\n[map addRelationshipMapping:associationMap];", @association.to_rest_kit_mapping
  end
  
end