require 'test_helper'

class PostTest < ActiveSupport::TestCase

  test "should create valid post" do
    post = Post.create(posts(:one).attributes)
    assert post.save
  end

  test "should require post text" do
    post = Post.create(posts(:noText).attributes)
    assert !post.save
  end

  test "should require user id" do
    post = Post.create(posts(:noUser).attributes)
    assert !post.save
  end

  test "should start at 1 post votes" do
    post = Post.create(posts(:noVotes).attributes)
    puts post.vote_count
    assert assert_equal(post.vote_count, 1)
  end

  test "should make post vote go up" do
    oldVotes = posts(:one).vote_count
    puts oldVotes
    PostVote.create(post_votes(:five).attributes)
    assert assert_equal(posts(:one).vote_count, oldVotes + 1)
  end

end