/*
  collection_check_boxes_in_groups_of.js
  Looks for a simple_form collection with data-in-groups-of set, and splits it
  into Bootstrap-friendly rows.
*/

$.fn.inGroupsOf = function( countPerGroup ) {
    
    var groups = [], offset = 0, $group;
    
    while ( ($group = this.slice( offset, (countPerGroup + offset) )).length ) {
        groups.push( $group );
        offset += countPerGroup;
    }
    
    return groups;
};

$(function() {
  if($('[data-in-groups-of]').length > 0) {
    $.each($('[data-in-groups-of]'), function(index, collection) {
      var group_count = $(collection).data('in-groups-of');
      var tags_to_group = $(collection).find($(collection).data('grouped-tag')).inGroupsOf(group_count);
      
      $.each(tags_to_group, function(i, tags) {
        tags.addClass('col-md-' + parseInt(12 / group_count));
        tags.wrapAll('<div class="row"></div>');
      });
    });
  } 
});