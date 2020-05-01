$('#request tbody').prepend("<%= j(render 'form', :test_result => @test_result) %>");
$('#button-new').hide();