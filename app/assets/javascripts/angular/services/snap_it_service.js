// ----------------------------------------
// SnapItService
// ----------------------------------------

Editor.factory('SnapItService',
  ['_', 'Restangular',
  function(_, Restangular) {

    var _themes;
    var _languages;

    var SnapItService = {};


    SnapItService.getLanguages = function() {
      if (_languages) {
        return _languages;
      } else {
        return Restangular.all('snap_it_languages').getList()
          .then(function(response) {
            return _languages = response.data;
          }, function(response) {
            console.error(response);
          });
      }
    };

    SnapItService.getThemes = function() {
      if (_themes) {
        return _themes;
      } else {
        return Restangular.all('snap_it_themes').getList()
          .then(function(response) {
            return _themes = response.data;
          }, function(response) {
            console.error(repsonse);
          });
      }
    };


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




