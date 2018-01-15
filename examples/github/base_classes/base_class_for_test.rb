require 'minitest/autorun'

require_relative '../../../lib/helpers/test_helper'
require_relative '../api/api_client'
require_relative '../ui/ui_client'

class BaseClassForTest < Minitest::Test

  def prelude
    raise 'No block given' unless (block_given?)
    log_dir_path = TestHelper.get_app_log_dir_path('github_api')
    TestHelper.test(self, log_dir_path) do |log|
      @repo_username = ENV['REPO_USERNAME']
      @repo_password = ENV['REPO_PASSWORD']
      @repo_name = ENV['REPO_NAME']
      unless @repo_username && @repo_password && @repo_name
        message = 'ENV must define REPO_USERNAME, REPO_PASSWORD, REPO_NAME'
        raise RuntimeError.new(message)
      end
      log.section('Test') do
        yield log
      end
    end
  end

  def with_api_client(log)
    ApiClient.with(log, @repo_username, @repo_password, @repo_name) do |api_client|
      yield api_client
    end
  end

  def with_ui_client(log)
    UiClient.with(log, @repo_username, @repo_password, @repo_name) do |ui_client, home_page|
      yield ui_client, home_page
    end
  end

end

