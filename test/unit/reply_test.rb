require 'test_helper'

class ReplyTest < ActiveSupport::TestCase

  test "should create valid reply" do
      reply = Reply.create(replies(:one).attributes)
      assert reply.save
  end

  test "should prevent reply to non-existing post" do
    reply = Reply.create(replies(:nonExistPost).attributes)
      assert reply.save
  end

  test "should require reply text" do
    reply = Reply.create(replies(:noText).attributes)
    assert !reply.save
  end

  test "should require user id" do
    reply = Reply.create(replies(:noUser).attributes)
    assert !reply.save
  end

  test "should start at 0 reply votes" do
    reply = Reply.create(replies(:noVotes).attributes)
    puts reply.vote_count
    assert assert_equal(reply.vote_count, 0)
  end

  test "should make reply vote go up" do
    oldVotes = replies(:one).vote_count
    puts oldVotes
    ReplyVote.create(reply_votes(:four).attributes)
    assert assert_equal(replies(:one).vote_count, oldVotes + 1)
  end

end