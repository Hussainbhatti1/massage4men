function send_email() {

	var str="";
	$(".search-choice").children('span').each(function(index,element) {
	  str+=$(element).text() + "," ;
	});
	email_body= $('#email_body').val()
	$.ajax({
            type: "POST",
            url: "/admin/emails/send_email?carrier=web",
            dataType: "json",
            data: {
                subject: $("#email_subject").val(),
                email_id:str,
                body:email_body
            }
        });
 }