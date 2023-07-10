require "application_system_test_case"

class WarnsTest < ApplicationSystemTestCase
  setup do
    @warn = warns(:one)
  end

  test "visiting the index" do
    visit warns_url
    assert_selector "h1", text: "Warns"
  end

  test "creating a Warn" do
    visit warns_url
    click_on "New Warn"

    fill_in "Administrator", with: @warn.administrator_id
    fill_in "User", with: @warn.user_id
    click_on "Create Warn"

    assert_text "Warn was successfully created"
    click_on "Back"
  end

  test "updating a Warn" do
    visit warns_url
    click_on "Edit", match: :first

    fill_in "Administrator", with: @warn.administrator_id
    fill_in "User", with: @warn.user_id
    click_on "Update Warn"

    assert_text "Warn was successfully updated"
    click_on "Back"
  end

  test "destroying a Warn" do
    visit warns_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Warn was successfully destroyed"
  end
end
