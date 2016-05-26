// ----------------------------------------
// TagService
// ----------------------------------------


CodeSnapIt.factory('TagService',
  ['_', 'Restangular',
  function(_, Restangular) {

    var _tags;


    var TagService = {};


    TagService.all = function() {
      if (_tags) {
        return new Promise(function(resolve) { resolve(_tags) });
      } else {
        return Restangular.all('tags').getList()
          .then(function(response) {
            return _tags = response;
          }, function(response) {
            console.error(response);
            return response;
          });
      }
    };

    return TagService;

  }]);




