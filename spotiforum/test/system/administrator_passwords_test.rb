require "application_system_test_case"

class AdministratorPasswordsTest < ApplicationSystemTestCase
  setup do
    @administrator_password = administrator_passwords(:one)
  end

  test "visiting the index" do
    visit administrator_passwords_url
    assert_selector "h1", text: "Administrator Passwords"
  end

  test "creating a Administrator password" do
    visit administrator_passwords_url
    click_on "New Administrator Password"

    fill_in "Password", with: @administrator_password.password
    fill_in "Salt", with: @administrator_password.salt
    click_on "Create Administrator password"

    assert_text "Administrator password was successfully created"
    click_on "Back"
  end

  test "updating a Administrator password" do
    visit administrator_passwords_url
    click_on "Edit", match: :first

    fill_in "Password", with: @administrator_password.password
    fill_in "Salt", with: @administrator_password.salt
    click_on "Update Administrator password"

    assert_text "Administrator password was successfully updated"
    click_on "Back"
  end

  test "destroying a Administrator password" do
    visit administrator_passwords_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Administrator password was successfully destroyed"
  end
end
