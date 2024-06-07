require 'test_helper'

class OrderHeadersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order_header = order_headers(:one)
  end

  test "should get index" do
    get order_headers_url
    assert_response :success
  end

  test "should get new" do
    get new_order_header_url
    assert_response :success
  end

  test "should create order_header" do
    assert_difference('OrderHeader.count') do
      post order_headers_url, params: { order_header: { customer_name: @order_header.customer_name, invoice_date: @order_header.invoice_date, invoice_number: @order_header.invoice_number, number: @order_header.number, state: @order_header.state } }
    end

    assert_redirected_to order_header_url(OrderHeader.last)
  end

  test "should show order_header" do
    get order_header_url(@order_header)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_header_url(@order_header)
    assert_response :success
  end

  test "should update order_header" do
    patch order_header_url(@order_header), params: { order_header: { customer_name: @order_header.customer_name, invoice_date: @order_header.invoice_date, invoice_number: @order_header.invoice_number, number: @order_header.number, state: @order_header.state } }
    assert_redirected_to order_header_url(@order_header)
  end

  test "should destroy order_header" do
    assert_difference('OrderHeader.count', -1) do
      delete order_header_url(@order_header)
    end

    assert_redirected_to order_headers_url
  end
end
