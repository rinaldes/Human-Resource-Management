<% if @test_result.save %>
	$('#request tbody tr:eq(0)').remove();
	$('#request tbody').prepend("<%= j(render 'data', :test_result => @test_result) %>");
	$('#button-new').show();
<% else %>
	
<% end %>