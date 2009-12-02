require 'test_helper'

class ChirpsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:chirps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create chirp" do
    assert_difference('Chirp.count') do
      post :create, :chirp => { }
    end

    assert_redirected_to chirp_path(assigns(:chirp))
  end

  test "should show chirp" do
    get :show, :id => chirps(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => chirps(:one).to_param
    assert_response :success
  end

  test "should update chirp" do
    put :update, :id => chirps(:one).to_param, :chirp => { }
    assert_redirected_to chirp_path(assigns(:chirp))
  end

  test "should destroy chirp" do
    assert_difference('Chirp.count', -1) do
      delete :destroy, :id => chirps(:one).to_param
    end

    assert_redirected_to chirps_path
  end
end
