require 'test_helper'

class ReplyVotesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:two)
    @reply = replies(:one)
    @reply_vote = reply_votes(:one)
    @reply_vote2 = reply_votes(:two)
    @reply_vote3 = reply_votes(:three)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reply_votes)
  end

  test "should get new" do
    get :new, :reply => { :format => @reply.id }
    get :new
    assert_response :success
  end

  test "should create reply_vote" do
    assert_difference('ReplyVote.count') do
      post :create, reply_vote: @reply_vote.attributes
    end
    assert_redirected_to reply_vote_path(assigns(:reply_vote))
  end

  test "should show reply_vote" do
    get :show, id: @reply_vote.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reply_vote.to_param
    assert_response :success
  end

  test "should update reply_vote" do
    put :update, id: @reply_vote.to_param, reply_vote: @reply_vote.attributes
    assert_redirected_to reply_vote_path(assigns(:reply_vote))
  end

  test "should destroy reply_vote" do
    assert_difference('ReplyVote.count', -1) do
      delete :destroy, id: @reply_vote.to_param
    end
    assert_redirected_to reply_votes_path
  end

  teardown do
    sign_out users(:one)         # sign_out(resource)
  end
end
