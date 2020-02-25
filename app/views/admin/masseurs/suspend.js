$('.suspend-user').bind('ajax:success', function() {
 
    $(this).closest('tr').fadeOut();
});
    //  Update the number in the header

