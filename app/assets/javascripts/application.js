// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require js/app.min
//= require izitoast/js/iziToast.min
//= require select2/dist/js/select2.full.min
//= require datatables/datatables.min
//= require datatables/DataTables-1.10.16/js/dataTables.bootstrap4.min
//= require datatables/export-tables/dataTables.buttons.min
//= require datatables/export-tables/buttons.flash.min
//= require datatables/export-tables/jszip.min
//= require datatables/export-tables/pdfmake.min
//= require datatables/export-tables/vfs_fonts
//= require datatables/export-tables/buttons.print.min
//= require jquery-ui/jquery-ui.min
//= require jquery-validation/dist/jquery.validate.min
//= require js/scripts
//= require js/custom
//= require activestorage
// require turbolinks
// require_tree .

$(function() {

  rupiah();
  function rupiah() {
      $('.rupiah').each(function(i, o) {
          $(o).val(formatCurrency($(o).val()));
      });
      $('.rupiah').on('focus', function(){
          if (parseFloat(formatCurrencyCleaner($(this).val())) == 0) {
              $(this).val('0.0');
          }
      });
      $('.rupiah').on('blur', function(){
          if ($(this).val() == '') {
              $(this).val('0.0');
          }
      });
      $('.rupiah').keyup(function(e){
          if ( /^-?\d+\.\d{1,2}/g.test(this.value) || /^-?\d+/g.test(this.value) || /^-$/g.test(this.value) ) {
              if (/^-?\d+\.\d{1,2}/g.test(this.value)) {
                  $(this).val(formatCurrency($(this).val()));
              } else if (/^-?\d+/g.test(this.value)) {
                  $(this).val(formatCurrency($(this).val()));
              } else if (/^-$/g.test(this.value)) {
                  $(this).val(formatCurrency($(this).val()));
              } else if (/^-?\D*\d+\D*/g.test(this.value)) {
                  this.value = this.value.replace(this.value, '');
              } else {
                  $(this).val(formatCurrency($(this).val()));
              }
          } else {
              this.value = this.value.replace(this.value, '');
          }
      });
  }

  $(".submitForm").on("click", function() {
      $('.rupiah').each(function(i, o) {
          var theVal = $(o).val();
          $(o).val(formatCurrencyCleaner(theVal));
      });
  });
});

window.formatCurrency = function(num){

  var str = num.toString(),str2=num.toString(), parts = true,parts2 = true, output = [], i = 1, formatted = null
  var separator = ",", delimiter = ".", delimiter2="-";
  var pecah = str.indexOf(delimiter);
  var pecah2 = str.indexOf(delimiter2);


  if(pecah > 0 && pecah2<0) {
      parts = str.split(delimiter);
      str = parts[0];
  }
  else if(pecah > 0 && pecah2==0) {

      parts = str.split(delimiter);
      str = parts[0];

      parts2 = str.split(delimiter2);
      str2 = parts2[0];
      str=parts2[1]
  }
  else if(pecah < 0 && pecah2==0) {
      parts = str.split(delimiter2);
      str = parts[1];
  }
  else{
      str = num.toString()
  }

  str = str.split(separator).join("");
  str = str.split("").reverse();

  for(var j = 0, len = str.length; j < len; j++) {
      if(!isNaN(str[j])){
          output.push(str[j]);
      }
  }
  str= output.join("");

  output = []
  for(var j = 0, len = str.length; j < len; j++) {

      output.push(str[j]);

      if(i%3 == 0 && j < (len - 1)) {
          output.push(",");
      }
      i++;
  }
  formatted = output.reverse().join("");
  if(pecah > 0 && pecah2<0){
      if(parts[1]==""){
          return(formatted + ((parts) ? "." + parts[1].substr(0, 2) : ""));
      }
      else{
          return(formatted + (!isNaN(parts[1]) ? "." + parts[1].substr(0, 2) : ""));
      }
  }
  else if(pecah < 0 && pecah2==0){
      return("-"+formatted);
  }
  else if(pecah > 0 && pecah2==0){
      return ("-"+formatted+((parts) ? "." + parts[1].substr(0, 2) : ""))
  }
  else{
      return formatted
  }
};

window.formatCurrencyCleaner = function(num) {
  numVal = parseFloat(num.split(',').join('')) * 1;
  return numVal;
};
