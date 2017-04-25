require_relative 'base_class_for_test'

require_relative '../endpoints/comments/get_comments'
require_relative '../endpoints/comments/get_comments_id'

require_relative '../data/comment'
require_relative '../../../lib/log/log'

class CommentsTest < BaseClassForTest

  def test_get_comments

    prelude do |client, log|

      GetComments.verdict_call_and_verify_success(client, log, 'get comments')

    end

  end

  def test_get_comments_id

    prelude do |client, log|

      comment_to_fetch = Comment.get_first(client)
      GetCommentsId.verdict_call_and_verify_success(client, log, 'get comment', comment_to_fetch)
    end
  end

end
