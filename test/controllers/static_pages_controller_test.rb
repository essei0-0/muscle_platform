require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Muscle Platform"
  end

  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "お問い合わせ｜Muscle Platform"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "使い方｜Muscle Platform"
  end
end
