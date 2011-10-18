require 'test_helper'

class ReplyVoteTest < ActiveSupport::TestCase

    test "should create valid reply vote" do
    replyVote = ReplyVote.create(reply_votes(:one).attributes)
    assert replyVote.save
  end

  test "should prevent vote to non existing reply" do
    replyVote = ReplyVote.create(reply_votes(:nonExistReply).attributes)
    assert !replyVote.save
  end

  test "should require post id" do
    replyVote = ReplyVote.create(reply_votes(:noReply).attributes)
    assert !replyVote.save
  end

  test "should require user id" do
    replyVote = ReplyVote.create(reply_votes(:noUser).attributes)
    assert !replyVote.save
  end

  test "should not allow double vote" do
    replyVote1 = ReplyVote.create(reply_votes(:one).attributes)
    replyVote1.save
    replyVote2 = ReplyVote.create(reply_votes(:one).attributes)
    assert !replyVote2.save
  end

  test " should not self vote" do
    reply = Reply.create(replies(:one).attributes)
    puts reply.user_id
    replyVote = ReplyVote.create(reply_votes(:selfVote).attributes)
    puts replyVote.user_id
    assert !replyVote.save
  end

end
