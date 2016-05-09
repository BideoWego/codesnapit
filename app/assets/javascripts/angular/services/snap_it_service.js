// ----------------------------------------
// SnapItService
// ----------------------------------------

Editor.factory('SnapItService',
  ['_', 'Restangular',
  function(_, Restangular) {

    var SnapItService = {};


    SnapItService.create = function(params) {
      return Restangular.all('snap_its').post({
        snap_it: {
          token: params.token
        }
      });
    };

    return SnapItService;

  }]);




