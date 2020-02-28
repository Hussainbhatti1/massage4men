$( document ).ready(function() {
	$("#client_password").addClass("verify-text");
  $("img").lazyload();
});


function client_password_eye() {
    var x = document.getElementById("client_password");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function client_confirm_password_eye() {
    var x = document.getElementById("client_password_confirmation");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function masseur_password_eye() {
    var x = document.getElementById("masseur_password");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}


function masseur_confirm_password_eye() {
    var x = document.getElementById("masseur_password_confirmation");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}


function masseur_current_password_eye() {
    var x = document.getElementById("masseur_current_password");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function client_current_password_eye() {
    var x = document.getElementById("client_current_password");
    if (x.type === "password") {
        x.type = "text";
    } else {
        x.type = "password";
    }
}

function confirm_password(event) {
  $("#toast-container").remove();

  var password1 = $("#client_password").val();
  var password2 = $("#client_password_confirmation").val();

    if(password1 == password2 && password1 != "" && password2 != "") {   
        $("#client_password").removeClass("active-red");
    	$("#client_password_confirmation").removeClass("active-red");    
    	$("#error-message-password").hide();

    }
    else {
    	event.preventDefault(); 
    	$("#client_password").addClass("active-red");
    	$("#client_password_confirmation").addClass("active-red");
    	$("#error-message-password").show();
        toastr.info('Please Enter Valid Password')
    }
    
    check_client_first_name();
    check_client_last_name();
    check_email();
    check_dob2();
    check_dob3();
    check_dob1();
    check_client_screen_name();
    check_client_zip();
    check_client_city();
    check_client_state();
    check_client_photo();
}

function check_email(){
    var clientemail=$("#client_email").val();
    if(clientemail != ""){
        $("#client_email").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_email").addClass("active-red");
        toastr.info('Please Enter Valid Email Address')
    }    
}

function check_dob2(){
    var clientdob2i=$("#client_dob_2i").val();
    if(clientdob2i != ""){
        $("#client_dob_2i").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_dob_2i").addClass("active-red");
        toastr.info('Please Enter Birthday Month')
    }
}


function check_dob3(){
    var clientdob3i=$("#client_dob_3i").val();
    if(clientdob3i != ""){
        $("#client_dob_3i").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_dob_3i").addClass("active-red");
        toastr.info('Please Enter Birthday Day')
    }
}

function check_dob1(){
    var clientdob1i=$("#client_dob_1i").val();
    if(clientdob1i != ""){
        $("#client_dob_1i").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_dob_1i").addClass("active-red");
        toastr.info('Please Enter Birthday Year')
    }
}

function check_client_first_name(){
    var clientfirst_name=$("#client_first_name").val();
    if(clientfirst_name != ""){
        $("#client_first_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_first_name").addClass("active-red");
        toastr.info('Please Enter First Name')
    }   
}

function check_client_last_name(){
    var clientlast_name=$("#client_last_name").val();
    if(clientlast_name != ""){
        $("#client_last_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_last_name").addClass("active-red");
        toastr.info('Please Enter Last Name')
    }   
}

function check_client_screen_name(){
    var clientscreenname=$("#client_screen_name").val();
    if(clientscreenname != ""){
        $("#client_screen_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_screen_name").addClass("active-red");
    }   
}

function check_client_screen_name(){
    var clientscreenname=$("#client_screen_name").val();
    if(clientscreenname != ""){
        $("#client_screen_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_screen_name").addClass("active-red");
    }   
}

function check_client_zip(){
    var clientzip=$("#client_zip").val();
    if(clientzip != ""){
        $("#client_zip").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_zip").addClass("active-red");
        toastr.info('Please Enter Valid Zip code')
    }   
}

function check_client_city(){
    var clientcity=$("#client_city").val();
    if(clientcity != ""){
        $("#client_city").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_city").addClass("active-red");
        toastr.info('Please Enter City')
    }   
}

function check_client_state(){
    var clientstate=$("#client_state").val();
    if(clientstate != ""){
        $("#client_state").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#client_state").addClass("active-red");
        toastr.info('Please Choose State')
    }   
}

function check_client_photo(){
    var clientprofilephoto=$("#client_profile_photo").val();
    if(clientprofilephoto != ""){
        $(".profile-photo-preview").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $(".profile-photo-preview").addClass("active-red");
        toastr.info('Please Upload Valid Photo')
    }
}

function masseur_confirm_password(event) {
  var password1 = $("#masseur_password").val();
  var password2 = $("#masseur_password_confirmation").val();

    

    if(password1 == password2 && password1 != "" && password2 != "") {    
       $("#masseur_password").removeClass("active-red");
    	$("#masseur_password_confirmation").removeClass("active-red");    
    	$("#error-message-password").hide();
    }
    else {
    	event.preventDefault(); 
    	$("#masseur_password").addClass("active-red");
    	$("#masseur_password_confirmation").addClass("active-red");
    	$("#error-message-password").show();
        toastr.info('Please Enter Valid Password')

    	
    }
    
    check_masseur_first_name();
    check_masseur_last_name();
    check_masseur_photo();
    masseur_check_email();
    masseur_check_dob2();
    masseur_check_dob3();
    masseur_check_dob1();
    check_masseur_screen_name();
    check_masseur_zip();
    check_masseur_city();
    check_masseur_state();
    check_masseur_phone();
}

function check_masseur_first_name(){
    var masseurfirst_name=$("#masseur_first_name").val();
    if(masseurfirst_name != ""){
        $("#masseur_first_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_first_name").addClass("active-red");
        toastr.info('Please Enter First Name')
    }   
}

function check_masseur_last_name(){
    var masseurlast_name=$("#masseur_last_name").val();
    if(masseurlast_name != ""){
        $("#masseur_last_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_last_name").addClass("active-red");
        toastr.info('Please Enter Last Name')
    }   
}

function check_masseur_city(){
    var masseurcity=$("#masseur_mailing_city").val();
    if(masseurcity != ""){
        $("#masseur_mailing_city").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_city").addClass("active-red");
        toastr.info('Please Enter City')
    }   
}

function check_masseur_state(){
    var masseurstate=$("#masseur_mailing_state").val();
    if(masseurstate != ""){
        $("#masseur_mailing_state").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_state").addClass("active-red");
        toastr.info('Please Choose State')
    }   
}

function check_masseur_photo(){
    var masseurprofilephoto=$("#masseur_profile_photo").val();
    if(masseurprofilephoto != ""){
        $(".profile-photo-preview").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $(".profile-photo-preview").addClass("active-red");
        toastr.info('Please Upload Valid Photo')
    }
}

function masseur_check_email(){
    var masseuremail=$("#masseur_email").val();
    if(masseuremail != ""){
        $("#masseur_email").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_email").addClass("active-red");
        toastr.info('Please Enter Valid Email Address')
    }    
}

function masseur_check_dob2(){
    var masseurdob2i=$("#masseur_dob_2i").val();
    if(masseurdob2i != ""){
        $("#masseur_dob_2i").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_dob_2i").addClass("active-red");
        toastr.info('Please Enter Birthday Month')
    }
}


function masseur_check_dob3(){
    var masseurdob3i=$("#masseur_dob_3i").val();
    if(masseurdob3i != ""){
        $("#masseur_dob_3i").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_dob_3i").addClass("active-red");
        toastr.info('Please Enter Birthday Day')
    }
}

function masseur_check_dob1(){
    var masseurdob1i=$("#masseur_dob_1i").val();
    if(masseurdob1i != ""){
        $("#masseur_dob_1i").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_dob_1i").addClass("active-red");
        toastr.info('Please Enter Birthday Year')
    }
}

function check_masseur_screen_name(){
    var masseurscreenname=$("#masseur_screen_name").val();
    if(masseurscreenname != ""){
        $("#masseur_screen_name").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_screen_name").addClass("active-red");
        toastr.info('Please Enter Screen Name')
    }   
}

function check_masseur_zip(){
    var masseurzip=$("#masseur_mailing_zip").val();
    if(masseurzip != ""){
        $("#masseur_mailing_zip").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_zip").addClass("active-red");
        toastr.info('Please Enter Valid Zip code')
    }   
}

function check_masseur_phone(){
    var masseurphone=$("#masseur_contact_phone").val();
    if(masseurphone != ""){
        $("#masseur_contact_phone").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_contact_phone").addClass("active-red");
        toastr.info('Please Enter Valid Contact Number')
    }   
}

function masseur_address_require(event){   
    var masseurcurrentpassword = $("#masseur_mailing_address").val();
    
    if (masseurcurrentpassword != "") {
        $("#masseur_mailing_address").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_address").addClass("active-red");
        toastr.info('Please Enter Your Mailing Address')
    }

    masseur_city_name();
    masseur_state_name();
    masseur_country_name();
    check_masseur_zip()   
    check_masseur_phone();
}

function masseur_city_name(){
    
    var masseurmailingcity = $("#masseur_mailing_city").val();
    if (masseurmailingcity != "") {
        $("#masseur_mailing_city").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_city").addClass("active-red");
        toastr.info('Please Enter Your City Name')
    }
}
function masseur_state_name(){
    
    var masseurmailingstate = $("#masseur_mailing_state").val();
    if (masseurmailingstate != "") {
        $("#masseur_mailing_state").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_state").addClass("active-red");
        toastr.info('Please Select Your State Name')
    }
}
function masseur_country_name(){
    var masseurmailingcountry = $("#masseur_mailing_country").val();
    if (masseurmailingcountry != "") {
        $("#masseur_mailing_country").removeClass("active-red");
    }
    else{
        event.preventDefault();
        $("#masseur_mailing_country").addClass("active-red");
        toastr.info('Please Select Your Country Name')
    }
}