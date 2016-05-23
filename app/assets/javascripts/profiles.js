$(document).ready(function() {
  // Hover action on Following button
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

  // Tabs on profile pages
  $('#myTabs a').click(function (e) {
    e.preventDefault();
    $(this).tab('show');
  });

  $('#myTabs a[href="#snapits"]').tab('show');
  $('#myTabs a[href="#following"]').tab('show');
  $('#myTabs a[href="#followers"]').tab('show');
});



