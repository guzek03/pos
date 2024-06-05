require 'test_helper'

class ReceptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reception = receptions(:one)
  end

  test "should get index" do
    get receptions_url
    assert_response :success
  end

  test "should get new" do
    get new_reception_url
    assert_response :success
  end

  test "should create reception" do
    assert_difference('Reception.count') do
      post receptions_url, params: { reception: { is_confirm: @reception.is_confirm, item_id: @reception.item_id, notes: @reception.notes, number: @reception.number, qty: @reception.qty } }
    end

    assert_redirected_to reception_url(Reception.last)
  end

  test "should show reception" do
    get reception_url(@reception)
    assert_response :success
  end

  test "should get edit" do
    get edit_reception_url(@reception)
    assert_response :success
  end

  test "should update reception" do
    patch reception_url(@reception), params: { reception: { is_confirm: @reception.is_confirm, item_id: @reception.item_id, notes: @reception.notes, number: @reception.number, qty: @reception.qty } }
    assert_redirected_to reception_url(@reception)
  end

  test "should destroy reception" do
    assert_difference('Reception.count', -1) do
      delete reception_url(@reception)
    end

    assert_redirected_to receptions_url
  end
end
