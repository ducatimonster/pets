require 'test_helper'

class GroomingServicesControllerTest < ActionController::TestCase
  setup do
    @grooming_service = grooming_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grooming_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grooming_service" do
    assert_difference('GroomingService.count') do
      post :create, grooming_service: { grooming_id: @grooming_service.grooming_id, notes: @grooming_service.notes, service_id: @grooming_service.service_id }
    end

    assert_redirected_to grooming_service_path(assigns(:grooming_service))
  end

  test "should show grooming_service" do
    get :show, id: @grooming_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @grooming_service
    assert_response :success
  end

  test "should update grooming_service" do
    patch :update, id: @grooming_service, grooming_service: { grooming_id: @grooming_service.grooming_id, notes: @grooming_service.notes, service_id: @grooming_service.service_id }
    assert_redirected_to grooming_service_path(assigns(:grooming_service))
  end

  test "should destroy grooming_service" do
    assert_difference('GroomingService.count', -1) do
      delete :destroy, id: @grooming_service
    end

    assert_redirected_to grooming_services_path
  end
end
