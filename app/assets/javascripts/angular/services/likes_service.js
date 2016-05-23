Social.factory('LikesService', ['Restangular', function(Restangular){

  var index = function(parent_type, parent_id){
    return Restangular.all('likes').getList({
      parent_type: parent_type,
      parent_id: parent_id,
    });
  };

  var create = function(parent_type, parent_id){
    return Restangular.all('likes').post({
      parent_type: parent_type,
      parent_id: parent_id,
    });
  };

  var destroy = function(id){
    return Restangular.all('likes').customDELETE(id);
  };

  return {
    index: index,
    create: create,
    destroy: destroy,
  };

}]);