// Hover action on Following button
$(document).ready(function() {
  var followHoverIn = function(event){
    $(event.target)
      .html('<i class="fa fa-minus" aria-hidden="true"></i> Unfollow')
      .addClass('btn-danger')
      .removeClass('btn-primary');
  };

  var followHoverOut = function(event){
    $(event.target)
      .text('Following')
      .addClass('btn-primary')
      .removeClass('btn-danger');
  };

  $('.following-button')
    .hover(followHoverIn, followHoverOut);
});

