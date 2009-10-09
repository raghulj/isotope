require 'test_helper'

class GtdsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gtds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gtd" do
    assert_difference('Gtd.count') do
      post :create, :gtd => { }
    end

    assert_redirected_to gtd_path(assigns(:gtd))
  end

  test "should show gtd" do
    get :show, :id => gtds(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => gtds(:one).to_param
    assert_response :success
  end

  test "should update gtd" do
    put :update, :id => gtds(:one).to_param, :gtd => { }
    assert_redirected_to gtd_path(assigns(:gtd))
  end

  test "should destroy gtd" do
    assert_difference('Gtd.count', -1) do
      delete :destroy, :id => gtds(:one).to_param
    end

    assert_redirected_to gtds_path
  end
end
