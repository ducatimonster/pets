require 'test_helper'

class ClientPetsControllerTest < ActionController::TestCase
  setup do
    @client_pet = client_pets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:client_pets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create client_pet" do
    assert_difference('ClientPet.count') do
      post :create, client_pet: { client_id: @client_pet.client_id, pet_id: @client_pet.pet_id }
    end

    assert_redirected_to client_pet_path(assigns(:client_pet))
  end

  test "should show client_pet" do
    get :show, id: @client_pet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @client_pet
    assert_response :success
  end

  test "should update client_pet" do
    patch :update, id: @client_pet, client_pet: { client_id: @client_pet.client_id, pet_id: @client_pet.pet_id }
    assert_redirected_to client_pet_path(assigns(:client_pet))
  end

  test "should destroy client_pet" do
    assert_difference('ClientPet.count', -1) do
      delete :destroy, id: @client_pet
    end

    assert_redirected_to client_pets_path
  end
end
