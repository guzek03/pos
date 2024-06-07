$(function() {
  var items = '';
  $.ajax({
    type: "GET",
    url: "/items/get_items_active",
    success: function(data){
      items = data;
    }
  });

  $(".add_order_details").on("click", function(){
    $(this).parent().parent().parent(".order_details_tbody").append('\
      <tr>\
        <td>\
          '+items+'\
        </td>\
        <td class="qty_request_group">\
          <input type="number" name="order_header[order_details_attributes][][qty_request]" class="form-control qty_request" required>\
        </td>\
        <td class="price_exclude_group">\
          <input type="text" name="order_header[order_details_attributes][][price_exclude]" class="form-control rupiah price_exclude" readonly required>\
          <input type="hidden" name="order_header[order_details_attributes][][price_include]" class="form-control rupiah price_include" readonly required>\
          <input type="hidden" name="order_header[order_details_attributes][][percentage_ppn]" class="form-control rupiah percentage_ppn" readonly required>\
        </td>\
        <td align="center">\
          <button type="button" class="btn btn-sm btn-danger remove_order_details">-</button>\
        </td>\
      </tr>\
    ')
    setTimeout(function(){ 
      $('.rupiah').keyup(function(e){
        $(this).val(formatCurrency($(this).val())); 
      });
      $(".select2").select2();
      $(".select_item").on("change", function(){
        selectItem($(this));
      });

    }, 500);
  });

  $(".order_details_tbody").on('click', '.remove_order_details', function(){
    $(this).parent().parent().remove();
  });

  $(".order_details_tbody").on('click', '.remove_order_details_edit', function(){
    $(this).next(".order_detail_destroy").val(1);
    $(this).parent().parent().hide();
    // $(this).parent().parent().remove();
  });

  $(".select_item").on("change", function(){
    selectItem($(this));
  });

  function selectItem(trigger) {
    $.ajax({
      type: "GET",
      url: "/prices/" + trigger.val() + "/get_price",
      success: function(data){
        // console.log(data)
        trigger.parent().siblings(".price_exclude_group").children(".price_exclude").val(formatCurrency(parseFloat(data.price)));
        trigger.parent().siblings(".price_exclude_group").children(".price_include").val(formatCurrency(parseFloat(data.price_include)));
        trigger.parent().siblings(".price_exclude_group").children(".percentage_ppn").val(formatCurrency(parseFloat(data.percentage_ppn)));
      }
    });
  }
});
