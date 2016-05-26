Social.directive('comments', ['CommentsService', 'TagService', function(CommentsService, TagService) {

  return {
    templateUrl: '/templates/comments.html',
    restrict: 'E',
    scope: {
      parent: "=",
      currentUserId: "=",
      comments: "="
    },
    link: function(scope, element, attrs) {
      var type = scope.parent.type;
      var id = scope.parent.id;
      
      scope.comments = CommentsService.index(type, id).$object;

      scope.createComment = function(){
        if (scope.commentForm.$valid) {
          CommentsService.create(type, id, scope.formData.body)
            .then(function(comment){
              scope.formData.body = "";
              scope.comments.push(comment);
            });
        }        
      };

      scope.deleteComment = function(id){
        CommentsService.destroy(id)
          .then(function(comment){
            var idx = _.findIndex(scope.comments, ['id', comment.id]);
            scope.comments.splice(idx, 1);
          });
      };


      scope.initTagger = function() {
        var $textarea = angular.element(element).find('textarea');
        TagService.all().then(function(response) {
          $textarea
            .atwho({
              at: '#',
              data: response
            });
        });
      };

    }
  };

}]);