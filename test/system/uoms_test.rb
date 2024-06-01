require "application_system_test_case"

class UomsTest < ApplicationSystemTestCase
  setup do
    @uom = uoms(:one)
  end

  test "visiting the index" do
    visit uoms_url
    assert_selector "h1", text: "Uoms"
  end

  test "creating a Uom" do
    visit uoms_url
    click_on "New Uom"

    fill_in "Code", with: @uom.code
    fill_in "Name", with: @uom.name
    check "State" if @uom.state
    click_on "Create Uom"

    assert_text "Uom was successfully created"
    click_on "Back"
  end

  test "updating a Uom" do
    visit uoms_url
    click_on "Edit", match: :first

    fill_in "Code", with: @uom.code
    fill_in "Name", with: @uom.name
    check "State" if @uom.state
    click_on "Update Uom"

    assert_text "Uom was successfully updated"
    click_on "Back"
  end

  test "destroying a Uom" do
    visit uoms_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Uom was successfully destroyed"
  end
end
