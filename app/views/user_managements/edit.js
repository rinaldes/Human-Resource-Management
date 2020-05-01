$('#data_<%= @user.id %>').html("<%= j(render 'form', :user => @user) %>");
$('#button-new').hide();
// setTimeout(function(){$('input[type=radio].star').rating()}, 1000);
