require 'test_helper'
 
class Backend::BoxesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:boxes)
  end
 
  test "should get new" do
    get :new
    assert_response :success
  end
 
  test "should create box" do
    assert_difference('Box.count') do
      post :create, :box => { }
    end
 
    assert_redirected_to box_path(assigns(:box))
  end
 
  test "should show box" do
    get :show, :id => boxes(:one).id
    assert_response :success
  end
 
  test "should get edit" do
    get :edit, :id => boxes(:one).id
    assert_response :success
  end
 
  test "should update box" do
    put :update, :id => boxes(:one).id, :box => { }
    assert_redirected_to box_path(assigns(:box))
  end
 
  test "should destroy box" do
    assert_difference('Box.count', -1) do
      delete :destroy, :id => boxes(:one).id
    end
 
    assert_redirected_to boxes_path
  end
end