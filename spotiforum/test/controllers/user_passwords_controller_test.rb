require "test_helper"

class UserPasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_password = user_passwords(:one)
  end

  test "should get index" do
    get user_passwords_url
    assert_response :success
  end

  test "should get new" do
    get new_user_password_url
    assert_response :success
  end

  test "should create user_password" do
    assert_difference('UserPassword.count') do
      post user_passwords_url, params: { user_password: { password: @user_password.password, salt: @user_password.salt } }
    end

    assert_redirected_to user_password_url(UserPassword.last)
  end

  test "should show user_password" do
    get user_password_url(@user_password)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_password_url(@user_password)
    assert_response :success
  end

  test "should update user_password" do
    patch user_password_url(@user_password), params: { user_password: { password: @user_password.password, salt: @user_password.salt } }
    assert_redirected_to user_password_url(@user_password)
  end

  test "should destroy user_password" do
    assert_difference('UserPassword.count', -1) do
      delete user_password_url(@user_password)
    end

    assert_redirected_to user_passwords_url
  end
end
