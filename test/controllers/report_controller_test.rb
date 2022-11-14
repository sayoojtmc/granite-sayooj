# frozen_string_literal: true

require "test_helper"

class ReportControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = create(:user)
    @headers = headers(@user)
  end

  def test_should_generate_report_for_valid_user
    post report_path, headers: @headers
    body = response.parsed_body
    puts body
    assert_response :success
    assert_equal t("in_progress", action: "Report generation"), body["notice"]
  end
end
