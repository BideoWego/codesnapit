Social.directive('comments', ['CommentsService', function(CommentsService){

  return {
    templateUrl: '/templates/comments.html',
    restrict: 'E',
    scope: {
      parent: "=",
      currentUserId: "@"
    },
    link: function(scope, element, attrs){
      var type = scope.parent.type;
      var id = scope.parent.id;
      
      scope.thing = CommentsService.index(type, id).$object;
    }
  };

}]);