require 'test_helper'

class NoteTypesControllerTest < ActionController::TestCase
  setup do
    @note_type = note_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:note_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note_type" do
    assert_difference('NoteType.count') do
      post :create, note_type: { note_type: @note_type.note_type }
    end

    assert_redirected_to note_type_path(assigns(:note_type))
  end

  test "should show note_type" do
    get :show, id: @note_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note_type
    assert_response :success
  end

  test "should update note_type" do
    patch :update, id: @note_type, note_type: { note_type: @note_type.note_type }
    assert_redirected_to note_type_path(assigns(:note_type))
  end

  test "should destroy note_type" do
    assert_difference('NoteType.count', -1) do
      delete :destroy, id: @note_type
    end

    assert_redirected_to note_types_path
  end
end
