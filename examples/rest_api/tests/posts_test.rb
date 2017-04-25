require_relative 'base_class_for_test'

require_relative '../endpoints/posts/get_posts'
require_relative '../endpoints/posts/get_posts_id'

require_relative '../data/post'
require_relative '../../../lib/log/log'

class PostsTest < BaseClassForTest

  def test_get_posts

    prelude do |client, log|

      GetPosts.verdict_call_and_verify_success(client, log, 'get posts')

    end

  end

  def test_get_posts_id

    prelude do |client, log|

      post_to_fetch = Post.get_first(client)
      GetPostsId.verdict_call_and_verify_success(client, log, 'get post', post_to_fetch)
    end
  end

end
