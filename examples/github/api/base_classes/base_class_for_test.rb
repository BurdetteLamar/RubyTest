require 'minitest/autorun'

require_relative '../../../../lib/helpers/test_helper'
require_relative '../github_client'

class BaseClassForTest < Minitest::Test

  def prelude
    raise 'No block given' unless (block_given?)
    log_dir_path = TestHelper.get_app_log_dir_path('github_api')
    TestHelper.test(self, log_dir_path) do |log|
      repo_username = ENV['REPO_USERNAME']
      repo_password = ENV['REPO_PASSWORD']
      repo_name = ENV['REPO_NAME']
      unless repo_username && repo_password && repo_name
        message = 'ENV must define REPO_USERNAME, REPO_PASSWORD, REPO_NAME'
        raise RuntimeError.new(message)
      end
      GithubClient.with(log, repo_username, ENV['REPO_PASSWORD'], ENV['REPO_NAME']) do |client|
        yield client, log
      end
    end
  end

end

