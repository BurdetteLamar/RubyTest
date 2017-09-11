require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/comments/delete_comments_id'
require_relative '../endpoints/comments/get_comments'
require_relative '../endpoints/comments/get_comments_id'
require_relative '../endpoints/comments/post_comments'
require_relative '../endpoints/comments/put_comments_id'

class CommentsTest < BaseClassForTest

  def test_delete_comments_id

    prelude do |client, log|
      log.section('Test DeleteCommentsId') do
        comment_to_delete = nil
        log.section('Get a comment to delete') do
          comment_to_delete = Comment.get_first(client)
        end
        log.section('Delete the comment') do
          # Some verdicts should fail, because JSONplaceholder will not actually delete the comment.
          DeleteCommentsId.verdict_call_and_verify_success(client, log, 'delete comment', comment_to_delete)
        end
      end
    end
  end

  def test_get_comments

    prelude do |client, log|
      log.section('Test GetComments') do

        all_comments = nil

        log.section('GetComments with no query') do
          all_comments = GetComments.verdict_call_and_verify_success(client, log, 'with no query')
        end

        log.section('GetComments with simple query') do
          comment = all_comments.first
          query_elements = {
              :postId => comment.postId,
          }
          expected_comments = all_comments.select { |p| p.postId == comment.postId }
          actual_comments = GetComments.call(client, query_elements)
          if log.verdict_assert_equal?('count for simple query', expected_comments.size, actual_comments.size, 'Count')
            (0...expected_comments.size).each do |i|
              expected_comment = expected_comments[i]
              actual_comment = actual_comments[i]
              Comment.verdict_equal?(log, 'with simple query %d' % i, expected_comment, actual_comment, 'Comment %d' % i)
            end
          end
        end

        log.section('GetComments with complex query') do
          comment = all_comments.first
          query_elements = {
              :postId => comment.postId,
              :name => comment.name,
          }
          expected_comments = all_comments.select { |p| (p.postId == comment.postId) && (p.name == comment.name) }
          actual_comments = GetComments.call(client, query_elements)
          if log.verdict_assert_equal?('count for complex query', expected_comments.size, actual_comments.size, 'Count')
            (0...expected_comments.size).each do |i|
              expected_comment = expected_comments[i]
              actual_comment = actual_comments[i]
              Comment.verdict_equal?(log, 'with complex query %d' % i, expected_comment, actual_comment, 'Comment %d' % i)
            end
          end
        end

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
        # Some verdicts should fail, because JSONplaceholder will not actually create the comment.
        PostComments.verdict_call_and_verify_success(client, log, 'comment to_create', comment_to_post)
      end
    end

  end

  def test_put_comments_id

    prelude do |client, log|
      log.section('Test PutCommentsId') do
        comment_to_put = nil
        log.section('Get a comment to put') do
          comment_original = Comment.get_first(client)
          comment_to_put = comment_original.clone
        end
        log.section('Put the modifications') do
          comment_to_put.name = 'NewName'
          comment_to_put.email = 'New@Email.com'
          comment_to_put.body = 'New body'
          # Some verdicts should fail, because JSONplaceholder will not actually update the comment.
          PutCommentsId.verdict_call_and_verify_success(client, log, 'Comment to put', comment_to_put)
        end
      end

    end

  end

end

