module ItemsHelper
  def items_html(selected = "")
    raw select_tag "order_header[order_details_attributes][][item_id]",
    options_from_collection_for_select(@items, "id", "sku_name", selected), class: "form-control select2 select_item", prompt: "-- select --"
  end
end
