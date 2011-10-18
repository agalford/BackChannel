require 'test_helper'

class PostVoteTest < ActiveSupport::TestCase

  test "should create valid post vote" do
    postVote = PostVote.create(post_votes(:one).attributes)
    assert postVote.save
  end

  test "should prevent vote to non-existing post" do
    postVote = PostVote.create(post_votes(:nonExistPost).attributes)
    assert !postVote.save
  end

  test "should require post id" do
    postVote = PostVote.create(post_votes(:noPost).attributes)
    assert !postVote.save
  end

  test "should require user id" do
    postVote = PostVote.create(post_votes(:noUser).attributes)
    assert !postVote.save
  end

  test "should not allow double vote" do
    postVote1 = PostVote.create(post_votes(:one).attributes)
    postVote1.save
    postVote2 = PostVote.create(post_votes(:one).attributes)
    assert !postVote2.save
  end

  test " should not self vote" do
    post = Post.create(posts(:one).attributes)
    puts post.id
    puts post.user_id
    postVote = PostVote.create(post_votes(:selfVote).attributes)
    puts postVote.post_id
    puts postVote.user_id
    assert !postVote.save
  end

end