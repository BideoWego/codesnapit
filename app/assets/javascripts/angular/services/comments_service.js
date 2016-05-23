Social.factory('CommentsService', ['Restangular', function(Restangular){

  var index = function(parent_type, parent_id){
    return Restangular.all('comments').getList({
      parent_type: parent_type,
      parent_id: parent_id,
    });
  };

  var create = function(parent_type, parent_id, body){
    return Restangular.all('comments').post({
      parent_type: parent_type,
      parent_id: parent_id,
      body: body
    });
  };

  var destroy = function(id){
    return Restangular.customDELETE('comments', {id: id});
  };

  return {
    index: index,
    create: create,
    destroy: destroy,
  };

}]);