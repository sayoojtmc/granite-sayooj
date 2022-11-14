# frozen_string_literal: true

require "test_helper"

class ReportsWorkerTest < ActiveSupport::TestCase
  def setup
    @user = create(:user)
    timestamp = Time.zone.today.strftime("%d%m%y")
    @file_path = Rails.root.join("tmp/#{@user.name}_#{timestamp}.pdf")
  end

  def test_report_generating_file
    ReportsWorker.perform_async(@user.id, @file_path)
    assert File.file?(@file_path)
  end
end
