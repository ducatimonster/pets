require 'test_helper'

class PetImageReposControllerTest < ActionController::TestCase
  setup do
    @pet_image_repo = pet_image_repos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pet_image_repos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pet_image_repo" do
    assert_difference('PetImageRepo.count') do
      post :create, pet_image_repo: { comment: @pet_image_repo.comment, pet_id: @pet_image_repo.pet_id }
    end

    assert_redirected_to pet_image_repo_path(assigns(:pet_image_repo))
  end

  test "should show pet_image_repo" do
    get :show, id: @pet_image_repo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pet_image_repo
    assert_response :success
  end

  test "should update pet_image_repo" do
    patch :update, id: @pet_image_repo, pet_image_repo: { comment: @pet_image_repo.comment, pet_id: @pet_image_repo.pet_id }
    assert_redirected_to pet_image_repo_path(assigns(:pet_image_repo))
  end

  test "should destroy pet_image_repo" do
    assert_difference('PetImageRepo.count', -1) do
      delete :destroy, id: @pet_image_repo
    end

    assert_redirected_to pet_image_repos_path
  end
end
