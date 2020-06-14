require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get static_pages_home_url
    assert_response :success
    assert_select "title", "ホーム｜Muscle Platform"
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
    assert_select "title", "お問い合わせ｜Muscle Platform"
  end

  test "should get about" do
    get static_pages_about_url
    assert_response :success
    assert_select "title", "使い方｜Muscle Platform"
  end
end
