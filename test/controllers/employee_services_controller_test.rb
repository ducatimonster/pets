require 'test_helper'

class EmployeeServicesControllerTest < ActionController::TestCase
  setup do
    @employee_service = employee_services(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:employee_services)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create employee_service" do
    assert_difference('EmployeeService.count') do
      post :create, employee_service: { employee_id: @employee_service.employee_id, service_id: @employee_service.service_id }
    end

    assert_redirected_to employee_service_path(assigns(:employee_service))
  end

  test "should show employee_service" do
    get :show, id: @employee_service
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @employee_service
    assert_response :success
  end

  test "should update employee_service" do
    patch :update, id: @employee_service, employee_service: { employee_id: @employee_service.employee_id, service_id: @employee_service.service_id }
    assert_redirected_to employee_service_path(assigns(:employee_service))
  end

  test "should destroy employee_service" do
    assert_difference('EmployeeService.count', -1) do
      delete :destroy, id: @employee_service
    end

    assert_redirected_to employee_services_path
  end
end
