require "test_helper"

class AdministratorPasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @administrator_password = administrator_passwords(:one)
  end

  test "should get index" do
    get administrator_passwords_url
    assert_response :success
  end

  test "should get new" do
    get new_administrator_password_url
    assert_response :success
  end

  test "should create administrator_password" do
    assert_difference('AdministratorPassword.count') do
      post administrator_passwords_url, params: { administrator_password: { password: @administrator_password.password, salt: @administrator_password.salt } }
    end

    assert_redirected_to administrator_password_url(AdministratorPassword.last)
  end

  test "should show administrator_password" do
    get administrator_password_url(@administrator_password)
    assert_response :success
  end

  test "should get edit" do
    get edit_administrator_password_url(@administrator_password)
    assert_response :success
  end

  test "should update administrator_password" do
    patch administrator_password_url(@administrator_password), params: { administrator_password: { password: @administrator_password.password, salt: @administrator_password.salt } }
    assert_redirected_to administrator_password_url(@administrator_password)
  end

  test "should destroy administrator_password" do
    assert_difference('AdministratorPassword.count', -1) do
      delete administrator_password_url(@administrator_password)
    end

    assert_redirected_to administrator_passwords_url
  end
end
