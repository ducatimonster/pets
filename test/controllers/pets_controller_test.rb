require 'test_helper'

class PetsControllerTest < ActionController::TestCase
  setup do
    @pet = pets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pet" do
    assert_difference('Pet.count') do
      post :create, pet: { client_id: @pet.client_id, is_spay_neutered: @pet.is_spay_neutered, pet_color: @pet.pet_color, pet_disclosure: @pet.pet_disclosure, pet_dob: @pet.pet_dob, pet_gender: @pet.pet_gender, pet_markings: @pet.pet_markings, pet_name: @pet.pet_name, pet_status_inactive: @pet.pet_status_inactive }
    end

    assert_redirected_to pet_path(assigns(:pet))
  end

  test "should show pet" do
    get :show, id: @pet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pet
    assert_response :success
  end

  test "should update pet" do
    patch :update, id: @pet, pet: { client_id: @pet.client_id, is_spay_neutered: @pet.is_spay_neutered, pet_color: @pet.pet_color, pet_disclosure: @pet.pet_disclosure, pet_dob: @pet.pet_dob, pet_gender: @pet.pet_gender, pet_markings: @pet.pet_markings, pet_name: @pet.pet_name, pet_status_inactive: @pet.pet_status_inactive }
    assert_redirected_to pet_path(assigns(:pet))
  end

  test "should destroy pet" do
    assert_difference('Pet.count', -1) do
      delete :destroy, id: @pet
    end

    assert_redirected_to pets_path
  end
end
