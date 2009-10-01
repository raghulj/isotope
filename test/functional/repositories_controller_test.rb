require 'test_helper'

class RepositoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:repositories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create repository" do
    assert_difference('Repository.count') do
      post :create, :repository => { }
    end

    assert_redirected_to repository_path(assigns(:repository))
  end

  test "should show repository" do
    get :show, :id => repositories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => repositories(:one).to_param
    assert_response :success
  end

  test "should update repository" do
    put :update, :id => repositories(:one).to_param, :repository => { }
    assert_redirected_to repository_path(assigns(:repository))
  end

  test "should destroy repository" do
    assert_difference('Repository.count', -1) do
      delete :destroy, :id => repositories(:one).to_param
    end

    assert_redirected_to repositories_path
  end
end
