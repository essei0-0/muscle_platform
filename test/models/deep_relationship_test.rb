require 'test_helper'

class DeepRelationshipTest < ActiveSupport::TestCase

  def setup
    @deep_relationship = DeepRelationship.new(teacher_id: users(:michael).id,
                                     student_id: users(:archer).id)
  end

  test "should be valid" do
    assert @deep_relationship.valid?
  end

  test "should require a follower_id" do
    @deep_relationship.teacher_id = nil
    assert_not @deep_relationship.valid?
  end

  test "should require a followed_id" do
    @deep_relationship.student_id = nil
    assert_not @deep_relationship.valid?
  end
end
