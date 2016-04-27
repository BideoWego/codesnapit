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
          title: params.title,
          description: params.description,
          font_size: params.fontSize,
          snap_it_language_id: params.language,
          snap_it_theme_id: params.theme
        }
      });
    };

    return SnapItService;

  }]);




