require_relative '../base_classes/base_class_for_test'

require_relative '../endpoints/posts/delete_posts_id'
require_relative '../endpoints/posts/get_posts'
require_relative '../endpoints/posts/get_posts_id'
require_relative '../endpoints/posts/post_posts'
require_relative '../endpoints/posts/put_posts_id'

require_relative '../data/post'
require_relative '../../../lib/log/log'

class PostsTest < BaseClassForTest

  def test_delete_posts_id

    prelude do |client, log|
      log.section('Test DeletePostsId') do
        post_to_delete = nil
        log.section('Get a post to delete') do
          post_to_delete = Post.get_first(client)
        end
        log.section('Delete the post') do
          # Some verdicts should fail, because JSONplaceholder will not actually delete the post.
          DeletePostsId.verdict_call_and_verify_success(client, log, 'delete post', post_to_delete)
        end
      end
    end
  end

  def test_get_posts

    prelude do |client, log|
      log.section('Test GetPosts') do

        all_posts = nil

        log.section('GetPosts with no query') do
          all_posts = GetPosts.verdict_call_and_verify_success(client, log, 'with no query')
        end

        log.section('GetPosts with simple query') do
          post = all_posts.first
          query_elements = {
              :userId => post.userId,
          }
          expected_posts = all_posts.select { |p| p.userId == post.userId }
          actual_posts = GetPosts.call(client, query_elements)
          if log.verdict_assert_equal?('count for simple query', expected_posts.size, actual_posts.size, 'Count')
            (0...expected_posts.size).each do |i|
              expected_post = expected_posts[i]
              actual_post = actual_posts[i]
              Post.verdict_equal?(log, 'with simple query %d' % i, expected_post, actual_post, 'Post %d' % i)
            end
          end
        end

        log.section('GetPosts with complex query') do
          post = all_posts.first
          query_elements = {
              :userId => post.userId,
              :title => post.title,
          }
          expected_posts = all_posts.select { |p| (p.userId == post.userId) && (p.title == post.title) }
          actual_posts = GetPosts.call(client, query_elements)
          if log.verdict_assert_equal?('count for complex query', expected_posts.size, actual_posts.size, 'Count')
            (0...expected_posts.size).each do |i|
              expected_post = expected_posts[i]
              actual_post = actual_posts[i]
              Post.verdict_equal?(log, 'with complex query %d' % i, expected_post, actual_post, 'Post %d' % i)
            end
          end
        end

      end

    end

  end

  def test_get_posts_id

    prelude do |client, log|
      log.section('Test GetPostsId') do
        post_to_fetch = nil
        log.section('Get a post to fetch') do
          post_to_fetch = Post.get_first(client)
        end
        log.section('Fetch the post') do
          GetPostsId.verdict_call_and_verify_success(client, log, 'get post', post_to_fetch)
        end
      end
    end

  end

  def test_post_posts

    prelude do |client, log|
      log.section('Test PostPosts') do
        post_to_post = Post.new(
            :id => 1,
            :userId => 1,
            :title => 'New title',
            :body => 'New body',
        )
        # Some verdicts should fail, because JSONplaceholder will not actually create the post.
        PostPosts.verdict_call_and_verify_success(client, log, 'post to_create', post_to_post)
      end
    end

  end

  def test_put_posts_id

    prelude do |client, log|
      log.section('Test PutPostsId') do
        post_to_put = nil
        log.section('Get a post to put') do
          post_original = Post.get_first(client)
          post_to_put = post_original.clone
        end
        log.section('Put the modifications') do
          post_to_put.title = 'New title'
          post_to_put.body = 'New body'
          # Some verdicts should fail, because JSONplaceholder will not actually update the post.
          PutPostsId.verdict_call_and_verify_success(client, log, 'Post to put', post_to_put)
        end
      end

    end

  end

end

