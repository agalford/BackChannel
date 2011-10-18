require 'test_helper'

class AdministratorsControllerTest < ActionController::TestCase
  setup do
    sign_in users(:one)
    @administrator = administrators(:one)
    @administrator2 = administrators(:two)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:administrators)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create administrator" do
    assert_difference('Administrator.count') do
      post :create, administrator: @administrator.attributes
    end
    assert_redirected_to administrator_path(assigns(:administrator))
  end

  test "should show administrator" do
    get :show, id: @administrator.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @administrator.to_param
    assert_response :success
  end

  test "should update administrator" do
    put :update, id: @administrator.to_param, administrator: @administrator.attributes
    assert_redirected_to administrator_path(assigns(:administrator))
  end

  test "should destroy administrator" do
    assert_difference('Administrator.count', -1) do
      delete :destroy, id: @administrator.to_param
    end
    assert_redirected_to administrators_path
  end

  teardown do
    sign_out users(:one)         # sign_out(resource)
  end
end
