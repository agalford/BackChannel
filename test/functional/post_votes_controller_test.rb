require 'test_helper'

class PostVotesControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @post = posts(:two)
    @post_vote = post_votes(:two)
    @post_vote2 = post_votes(:two)
    @post_vote3 = post_votes(:three)
    @post_vote4 = post_votes(:four)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_votes)
  end

  test "should get new" do
    puts @post.id
    get :new, :post => { :format => @post.id }
    #get :new
    assert_response :success
  end

  test "should create post_vote" do
    assert_difference('PostVote.count') do
      post :create, post_vote: @post_vote.attributes
    end
    assert_redirected_to post_vote_path(assigns(:post_vote))
  end

  test "should show post_vote" do
    get :show, id: @post_vote.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_vote.to_param
    assert_response :success
  end

  test "should update post_vote" do
    put :update, id: @post_vote.to_param, post_vote: @post_vote.attributes
    assert_redirected_to post_vote_path(assigns(:post_vote))
  end

  test "should destroy post_vote" do
    assert_difference('PostVote.count', -1) do
      delete :destroy, id: @post_vote.to_param
    end
    assert_redirected_to post_votes_path
  end

  teardown do
    sign_out users(:one)         # sign_out(resource)
  end
end
