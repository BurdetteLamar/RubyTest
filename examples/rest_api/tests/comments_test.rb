require_relative 'base_class_for_test'

require_relative '../endpoints/comments/delete_comments_id'
require_relative '../endpoints/comments/get_comments'
require_relative '../endpoints/comments/get_comments_id'
require_relative '../endpoints/comments/post_comments'
require_relative '../endpoints/comments/put_comments_id'

require_relative '../data/comment'
require_relative '../../../lib/log/log'

class CommentsTest < BaseClassForTest

  def test_delete_comments_id

    prelude do |client, log|
      log.section('Test DeleteComments') do
        comment_to_delete = nil
        log.section('Get a comment to delete') do
          comment_to_delete = Comment.get_first(client)
        end
        log.section('Delete the comment') do
          # This should fail, because JSONplaceholder will not actually delete the comment.
          DeleteCommentsId.verdict_call_and_verify_success(client, log, 'delete comment', comment_to_delete)
        end
      end
    end
  end

  def test_get_comments

    prelude do |client, log|
      log.section('Test GetComments') do
        GetComments.verdict_call_and_verify_success(client, log, 'get comments')
      end
    end

  end

  def test_get_comments_id

    prelude do |client, log|
      log.section('Test GetCommentsId') do
        comment_to_fetch = nil
        log.section('Get a comment to fetch') do
          comment_to_fetch = Comment.get_first(client)
        end
        log.section('Fetch the comment') do
          GetCommentsId.verdict_call_and_verify_success(client, log, 'get comment', comment_to_fetch)
        end
      end
    end

  end

  def test_post_comments

    prelude do |client, log|
      log.section('Test PostComments') do
        comment_to_post = Comment.new(
            :postId => 1,
            :id => 1,
            :name => 'NewName',
            :email => 'New@Email.com',
            :body => 'New body',
        )
        # This should fail, because JSONplaceholder will not actually create the comment.
        PostComments.verdict_call_and_verify_success(client, log, 'comment to_create', comment_to_post)
      end
    end

  end

  def test_put_comments_id

    prelude do |client, log|
      log.section('Test PutComments') do
        comment_to_put = nil
        log.section('Get a comment to put') do
          comment_original = Comment.get_first(client)
          comment_to_put = comment_original.clone
        end
        log.section('Put the modifications') do
          comment_to_put.name = 'NewName'
          comment_to_put.email = 'New@Email.com'
          comment_to_put.body = 'New body'
          # This should fail, because JSONplaceholder will not actually update the comment.
          PutCommentsId.verdict_call_and_verify_success(client, log, 'Comment to put', comment_to_put)
        end
      end

    end

  end

end

