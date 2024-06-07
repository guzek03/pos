require "application_system_test_case"

class OrderHeadersTest < ApplicationSystemTestCase
  setup do
    @order_header = order_headers(:one)
  end

  test "visiting the index" do
    visit order_headers_url
    assert_selector "h1", text: "Order Headers"
  end

  test "creating a Order header" do
    visit order_headers_url
    click_on "New Order Header"

    fill_in "Customer name", with: @order_header.customer_name
    fill_in "Invoice date", with: @order_header.invoice_date
    fill_in "Invoice number", with: @order_header.invoice_number
    fill_in "Number", with: @order_header.number
    fill_in "State", with: @order_header.state
    click_on "Create Order header"

    assert_text "Order header was successfully created"
    click_on "Back"
  end

  test "updating a Order header" do
    visit order_headers_url
    click_on "Edit", match: :first

    fill_in "Customer name", with: @order_header.customer_name
    fill_in "Invoice date", with: @order_header.invoice_date
    fill_in "Invoice number", with: @order_header.invoice_number
    fill_in "Number", with: @order_header.number
    fill_in "State", with: @order_header.state
    click_on "Update Order header"

    assert_text "Order header was successfully updated"
    click_on "Back"
  end

  test "destroying a Order header" do
    visit order_headers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order header was successfully destroyed"
  end
end
