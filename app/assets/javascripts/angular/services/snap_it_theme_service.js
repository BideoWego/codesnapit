// ----------------------------------------
// SnapItThemeService
// ----------------------------------------

Editor.factory('SnapItThemeService',
  ['_', 'Restangular',
  function(_, Restangular) {

    var _themes;

    var SnapItThemeService = {};

    SnapItThemeService.all = function() {
      if (_themes) {
        return _themes;
      } else {
        return Restangular.all('snap_it_themes').getList()
          .then(function(response) {
            return _themes = response;
          }, function(response) {
            console.error(response);
          });
      }
    };

    SnapItThemeService.findByName = function(name) {
      return _.find(_themes, function(theme) {
        if (theme.name === name) {
          return theme;
        }
      });
    };

    SnapItThemeService.findByEditorName = function(editorName) {
      return _.find(_themes, function(theme) {
        if (theme.editor_name === editorName) {
          return theme;
        }
      });
    };

    return SnapItThemeService;

  }]);




