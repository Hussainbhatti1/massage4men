/*jslint browser: true*/
/*global  $ initialize_slider */
$(document).on('ready', function() {
  "use strict";

  //  Load the first ad on document.ready
  var active_tab = $('.tab-pane.active');
  var ad_url = $('.ad-nav li.active a').attr('data-ad-url');
  
  load_ad(active_tab, ad_url);

  //  Handle tab changes
  $('a[data-toggle=tab]').on('shown.bs.tab', function(e) {
    //  Which tab was called?
    var ad_type = $(e.target).attr('data-ad-type');

    //  Get a reference to the tab we're working with
    var tab_pane = $('.tab-pane#' + ad_type);
    
    if(tab_pane.attr('data-loaded') == 'false') {
      //  What's the URL for this ad?
      var ad_url = $(e.target).attr('data-ad-url');

      //  Update the loading spinner
      tab_pane.find('span').text('loading ' + ad_type + ' ad...');
  
      load_ad(tab_pane, ad_url);              
    }
  });
});

function load_ad(element, ad_url) {  
  //  Load the ad into the tab pane
  element.load(ad_url, function() {
    initialize_slider(element.find('.slider-responsive'));
    element.attr('data-loaded', true);
  });  
}