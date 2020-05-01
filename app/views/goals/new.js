$('#goal tbody').prepend("<%= j( render 'form', :goal => @goal) %>");
$('#button-new').hide();
$('.input-append.date').datepicker({
  autoclose: true,
  todayHighlight: true
});