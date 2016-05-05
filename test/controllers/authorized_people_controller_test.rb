require 'test_helper'

class AuthorizedPeopleControllerTest < ActionController::TestCase
  setup do
    @authorized_person = authorized_people(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authorized_people)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create authorized_person" do
    assert_difference('AuthorizedPerson.count') do
      post :create, authorized_person: { authorized_person_telephone: @authorized_person.authorized_person_telephone, client_id: @authorized_person.client_id, full_name: @authorized_person.full_name }
    end

    assert_redirected_to authorized_person_path(assigns(:authorized_person))
  end

  test "should show authorized_person" do
    get :show, id: @authorized_person
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @authorized_person
    assert_response :success
  end

  test "should update authorized_person" do
    patch :update, id: @authorized_person, authorized_person: { authorized_person_telephone: @authorized_person.authorized_person_telephone, client_id: @authorized_person.client_id, full_name: @authorized_person.full_name }
    assert_redirected_to authorized_person_path(assigns(:authorized_person))
  end

  test "should destroy authorized_person" do
    assert_difference('AuthorizedPerson.count', -1) do
      delete :destroy, id: @authorized_person
    end

    assert_redirected_to authorized_people_path
  end
end
