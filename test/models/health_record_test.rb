require 'test_helper'

class HealthRecordTest < ActiveSupport::TestCase
  def setup
    @user = users(:michael)
    @health_record = @user.health_records.build(weight: 65)
  end

  test "should be valid" do
    assert @health_record.valid?
  end

  test "user id should be present" do
    @health_record.user_id = nil
    assert_not @health_record.valid?
  end

  test "order should be most recent first" do
    assert_equal health_records(:most_recent), HealthRecord.first
  end
end
