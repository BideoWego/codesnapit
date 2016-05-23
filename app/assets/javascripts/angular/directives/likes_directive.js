Social.directive('likes', ['LikesService', function(LikesService){

  return {
    templateUrl: '/templates/likes.html',
    restrict: 'E',
    scope: {
      parent: "=",
      currentUserId: "=",
    },
    link: function(scope, element, attrs){
      var type = scope.parent.type;
      var id = scope.parent.id;
      
      LikesService.index(type, id)
        .then(function(likes){
          scope.likes = likes;
          scope.userLike = _.find( likes, {'user_id': scope.currentUserId} );
        });

      scope.createLike = function(){
        LikesService.create(type, id)
          .then(function(like){
            scope.likes.push(like);
            scope.userLike = like;
          });
      };

      scope.deleteLike = function(id){
        LikesService.destroy(id)
          .then(function(like){
            var idx = _.findIndex(scope.likes, ['id', like.id]);
            scope.likes.splice(idx, 1);
            scope.userLike = null;
          });
      };
    }
  };

}]);