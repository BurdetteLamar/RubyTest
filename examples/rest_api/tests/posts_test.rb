require_relative 'base_class_for_test'

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
        GetPosts.verdict_call_and_verify_success(client, log, 'get posts')
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

