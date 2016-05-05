require 'test_helper'

class PetIncidentsControllerTest < ActionController::TestCase
  setup do
    @pet_incident = pet_incidents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:pet_incidents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pet_incident" do
    assert_difference('PetIncident.count') do
      post :create, pet_incident: { incident_date: @pet_incident.incident_date, incident_id: @pet_incident.incident_id, pet_id: @pet_incident.pet_id }
    end

    assert_redirected_to pet_incident_path(assigns(:pet_incident))
  end

  test "should show pet_incident" do
    get :show, id: @pet_incident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pet_incident
    assert_response :success
  end

  test "should update pet_incident" do
    patch :update, id: @pet_incident, pet_incident: { incident_date: @pet_incident.incident_date, incident_id: @pet_incident.incident_id, pet_id: @pet_incident.pet_id }
    assert_redirected_to pet_incident_path(assigns(:pet_incident))
  end

  test "should destroy pet_incident" do
    assert_difference('PetIncident.count', -1) do
      delete :destroy, id: @pet_incident
    end

    assert_redirected_to pet_incidents_path
  end
end
