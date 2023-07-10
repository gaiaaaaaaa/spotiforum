require "test_helper"

class WarnsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @warn = warns(:one)
  end

  test "should get index" do
    get warns_url
    assert_response :success
  end

  test "should get new" do
    get new_warn_url
    assert_response :success
  end

  test "should create warn" do
    assert_difference('Warn.count') do
      post warns_url, params: { warn: { administrator_id: @warn.administrator_id, user_id: @warn.user_id } }
    end

    assert_redirected_to warn_url(Warn.last)
  end

  test "should show warn" do
    get warn_url(@warn)
    assert_response :success
  end

  test "should get edit" do
    get edit_warn_url(@warn)
    assert_response :success
  end

  test "should update warn" do
    patch warn_url(@warn), params: { warn: { administrator_id: @warn.administrator_id, user_id: @warn.user_id } }
    assert_redirected_to warn_url(@warn)
  end

  test "should destroy warn" do
    assert_difference('Warn.count', -1) do
      delete warn_url(@warn)
    end

    assert_redirected_to warns_url
  end
end
