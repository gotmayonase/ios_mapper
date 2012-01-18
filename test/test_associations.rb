require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/ios_mapper'))

class TestAssociations < MiniTest::Unit::TestCase
  
  def setup
    @rails_association = MiniTest::Mock.new
    @rails_association.expect :class_name, 'Association'
  end
  
  def test_belongs_to_association_to_property
    @rails_association.expect :macro, :belongs_to
    @rails_association.expect :foreign_key, :association_id
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal "@property (nonatomic, retain) NSNumber *association_id;\n@property (nonatomic, retain) Association *association;", @association.to_ios_property
  end
  
  def test_has_many_association_to_property
    @rails_association.expect :macro, :has_many
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal '@property (nonatomic, retain) NSArray *associations;', @association.to_ios_property
  end
  
  def test_habtm_association_to_property
    @rails_association.expect :macro, :has_and_belongs_to_many
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal '@property (nonatomic, retain) NSArray *associations;', @association.to_ios_property
  end
  
  def test_has_many_through_association_to_property
    @rails_association.expect :macro, :has_many
    @rails_association.expect :options, { :through => :through_association }
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal '@property (nonatomic, retain) NSArray *associations;', @association.to_ios_property
  end
  
  def test_belongs_to_association_to_dealloc
    @rails_association.expect :macro, :belongs_to
    @rails_association.expect :foreign_key, :association_id
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal "self.association_id = nil;\nself.association = nil;", @association.to_dealloc_line
  end
  
  def test_has_many_association_to_dealloc
    @rails_association.expect :macro, :has_many
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal 'self.associations = nil;', @association.to_dealloc_line
  end
  
  def test_habtm_association_to_dealloc
    @rails_association.expect :macro, :has_and_belongs_to_many
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal 'self.associations = nil;', @association.to_dealloc_line
  end
  
  def test_has_many_through_association_to_dealloc
    @rails_association.expect :macro, :has_many
    @rails_association.expect :options, { :through => :through_association }
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal 'self.associations = nil;', @association.to_dealloc_line
  end
  
  def test_association_import_line
    @rails_association.expect :macro, :has_many
    @association = IosMapper::Association.setup(@rails_association)
    assert_equal "#import \"Association.h\"", @association.to_ios_import
  end
  
end