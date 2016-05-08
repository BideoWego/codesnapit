// ----------------------------------------
// SnapItLanguageService
// ----------------------------------------

Editor.factory('SnapItLanguageService',
  ['_', 'Restangular',
  function(_, Restangular) {

    var _languages;

    var SnapItLanguageService = {};

    SnapItLanguageService.all = function() {
      if (_languages) {
        return _languages;
      } else {
        return Restangular.all('snap_it_languages').getList()
          .then(function(response) {
            return _languages = response;
          }, function(response) {
            console.error(response);
          });
      }
    };

    SnapItLanguageService.findByName = function(name) {
      return _.find(_languages, function(language) {
        if (language.name === name) {
          return language;
        }
      });
    };

    SnapItLanguageService.findByEditorName = function(editorName) {
      return _.find(_languages, function(language) {
        if (language.editor_name === editorName) {
          return language;
        }
      });
    };

    return SnapItLanguageService;

  }]);




