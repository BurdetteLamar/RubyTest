require 'minitest/autorun'

require_relative '../../../lib/helpers/test_helper'
require_relative '../github_client'

class BaseClassForTest < Minitest::Test

  def prelude
    raise 'No block given' unless (block_given?)
    log_dir_path = TestHelper.get_app_log_dir_path('github_api')
    TestHelper.test(self, log_dir_path) do |log|
      GithubClient.with(log, ENV['REPO_USERNAME'], ENV['REPO_PASSWORD'], ENV['REPO_NAME']) do |client|
        yield client, log
      end
    end
  end

end

