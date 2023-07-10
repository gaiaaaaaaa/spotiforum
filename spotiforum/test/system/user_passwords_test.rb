require "application_system_test_case"

class UserPasswordsTest < ApplicationSystemTestCase
  setup do
    @user_password = user_passwords(:one)
  end

  test "visiting the index" do
    visit user_passwords_url
    assert_selector "h1", text: "User Passwords"
  end

  test "creating a User password" do
    visit user_passwords_url
    click_on "New User Password"

    fill_in "Password", with: @user_password.password
    fill_in "Salt", with: @user_password.salt
    click_on "Create User password"

    assert_text "User password was successfully created"
    click_on "Back"
  end

  test "updating a User password" do
    visit user_passwords_url
    click_on "Edit", match: :first

    fill_in "Password", with: @user_password.password
    fill_in "Salt", with: @user_password.salt
    click_on "Update User password"

    assert_text "User password was successfully updated"
    click_on "Back"
  end

  test "destroying a User password" do
    visit user_passwords_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "User password was successfully destroyed"
  end
end
