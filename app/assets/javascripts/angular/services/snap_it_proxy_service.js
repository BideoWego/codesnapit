// ----------------------------------------
// SnapItProxyService
// ----------------------------------------

Editor.factory('SnapItProxyService',
  ['_', 'Restangular',
  function(_, Restangular) {

    var SnapItProxyService = {};


    SnapItProxyService.create = function(params) {
      return Restangular.all('snap_it_proxies').post({
        snap_it_proxy: {
          title: params.title,
          description: params.description,
          body: params.body,
          font_size: params.fontSize,
          snap_it_language_id: params.language,
          snap_it_theme_id: params.theme
        }
      });
    };

    return SnapItProxyService;

  }]);




