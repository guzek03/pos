require "application_system_test_case"

class ReceptionsTest < ApplicationSystemTestCase
  setup do
    @reception = receptions(:one)
  end

  test "visiting the index" do
    visit receptions_url
    assert_selector "h1", text: "Receptions"
  end

  test "creating a Reception" do
    visit receptions_url
    click_on "New Reception"

    check "Is confirm" if @reception.is_confirm
    fill_in "Item", with: @reception.item_id
    fill_in "Notes", with: @reception.notes
    fill_in "Number", with: @reception.number
    fill_in "Qty", with: @reception.qty
    click_on "Create Reception"

    assert_text "Reception was successfully created"
    click_on "Back"
  end

  test "updating a Reception" do
    visit receptions_url
    click_on "Edit", match: :first

    check "Is confirm" if @reception.is_confirm
    fill_in "Item", with: @reception.item_id
    fill_in "Notes", with: @reception.notes
    fill_in "Number", with: @reception.number
    fill_in "Qty", with: @reception.qty
    click_on "Update Reception"

    assert_text "Reception was successfully updated"
    click_on "Back"
  end

  test "destroying a Reception" do
    visit receptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reception was successfully destroyed"
  end
end
