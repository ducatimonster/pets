require 'test_helper'

class ShotRecordsControllerTest < ActionController::TestCase
  setup do
    @shot_record = shot_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shot_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shot_record" do
    assert_difference('ShotRecord.count') do
      post :create, shot_record: { pet_id: @shot_record.pet_id, shot_date: @shot_record.shot_date, shot_expiration: @shot_record.shot_expiration, vaccination_id: @shot_record.vaccination_id }
    end

    assert_redirected_to shot_record_path(assigns(:shot_record))
  end

  test "should show shot_record" do
    get :show, id: @shot_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shot_record
    assert_response :success
  end

  test "should update shot_record" do
    patch :update, id: @shot_record, shot_record: { pet_id: @shot_record.pet_id, shot_date: @shot_record.shot_date, shot_expiration: @shot_record.shot_expiration, vaccination_id: @shot_record.vaccination_id }
    assert_redirected_to shot_record_path(assigns(:shot_record))
  end

  test "should destroy shot_record" do
    assert_difference('ShotRecord.count', -1) do
      delete :destroy, id: @shot_record
    end

    assert_redirected_to shot_records_path
  end
end
