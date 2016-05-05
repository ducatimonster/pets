require 'test_helper'

class GroomingsControllerTest < ActionController::TestCase
  setup do
    @grooming = groomings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groomings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grooming" do
    assert_difference('Grooming.count') do
      post :create, grooming: { arrival_time: @grooming.arrival_time, date: @grooming.date, fleas_ticks: @grooming.fleas_ticks, matted_tangled: @grooming.matted_tangled, pet_id: @grooming.pet_id, pickup_time: @grooming.pickup_time }
    end

    assert_redirected_to grooming_path(assigns(:grooming))
  end

  test "should show grooming" do
    get :show, id: @grooming
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grooming
    assert_response :success
  end

  test "should update grooming" do
    patch :update, id: @grooming, grooming: { arrival_time: @grooming.arrival_time, date: @grooming.date, fleas_ticks: @grooming.fleas_ticks, matted_tangled: @grooming.matted_tangled, pet_id: @grooming.pet_id, pickup_time: @grooming.pickup_time }
    assert_redirected_to grooming_path(assigns(:grooming))
  end

  test "should destroy grooming" do
    assert_difference('Grooming.count', -1) do
      delete :destroy, id: @grooming
    end

    assert_redirected_to groomings_path
  end
end
