require 'minitest/autorun'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/ios_mapper'))

class TestMappers < MiniTest::Unit::TestCase
  
  def setup
    @rails_association = MiniTest::Mock.new
    @rails_association.expect :class_name, 'Association'
    @klass = MiniTest::Mock.new
    @column = MiniTest::Mock.new
    @column.expect :type, :integer
    @column.expect :name, 'my_test_int'
    @klass.expect :columns, [@column]
    # @klass.expect :to_s, 'MyModel'
  end
  
  def test_mapping_basic_class
    
  end
  
  def test_mapping_class_with_paperclip_attachments
    
  end
  
  def test_mapping_class_with_restkit_enabled
    
  end
  
  def test_mapping_with_has_many_association
    @rails_association.expect :macro, :has_many
  end
  
  def test_mapping_with_belongs_to_association
    @rails_association.expect :macro, :belongs_to
    @rails_association.expect :foreign_key, :association_id
  end
  
  def test_mapping_with_has_many_through_association
    @rails_association.expect :macro, :has_many
    @rails_association.expect :options, { :through => :through_association }
  end
  
  def test_mapping_with_has_and_belongs_to_many_association
    @rails_association.expect :macro, :has_and_belongs_to_many
  end
  
end