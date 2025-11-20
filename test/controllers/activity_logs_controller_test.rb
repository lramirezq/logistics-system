require "test_helper"

class ActivityLogsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get activity_logs_index_url
    assert_response :success
  end

  test "should get show" do
    get activity_logs_show_url
    assert_response :success
  end
end
