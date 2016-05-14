// ----------------------------------------
// SnapItsCreateCtrl
// ----------------------------------------

Editor.controller('SnapItsCreateCtrl',
  [
    '_',
    '$scope',
    '$http',
    '$httpParamSerializerJQLike',
    '$q',
    'ace',
    'Flash',
    'SnapItService',
    'SnapItProxyService',
    'SnapItLanguageService',
    'SnapItThemeService',
  function(
    _,
    $scope,
    $http,
    $httpParamSerializerJQLike,
    $q,
    ace,
    Flash,
    SnapItService,
    SnapItProxyService,
    SnapItLanguageService,
    SnapItThemeService
  ) {

    var _editor;
    var _lastWrapLimit = 80;


    $scope.preview = {
      close: function() {
        $scope.preview.show = false;
      }
    };


    $q.all([
      SnapItLanguageService.all(),
      SnapItThemeService.all()
    ])
      .then(function(response) {
        var language = SnapItLanguageService.findByEditorName('javascript');
        var theme = SnapItThemeService.findByEditorName('monokai');

        $scope.snapItParams.language = language.editor_name;
        $scope.snapItParams.theme = theme.editor_name;
      });

    $scope.snapItParams = {
      fontSize: '18',
      wrapLimit: _lastWrapLimit,
      title: 'Awesome',
      description: 'Dude!'
    };


    $scope.aceLoaded = function(editor) {
      _editor = editor;
      _editor.setOption('showPrintMargin', false);
      _editor.$blockScrolling = Infinity;
      var session = _editor.getSession();
      session.setTabSize(2);
      session.setUseWorker(false);
    };


    $scope.aceChanged = function(_editor) {
      // Fires every editor change
    };


    $scope.fontSizeChanged = function() {
      var fontSize = $scope.snapItParams.fontSize;
      _editor.setFontSize(+fontSize);
    };


    $scope.wrapEnabledChanged = function() {
      $scope.snapItParams.wrapLimit = _lastWrapLimit;
      $scope.wrapLimitChanged();
    };


    $scope.wrapLimitChanged = function() {
      var value = null;
      if ($scope.snapItParams.isWrapEnabled) {
        value = $scope.snapItParams.wrapLimit;
      }
      _editor.getSession()
        .setWrapLimitRange(value, value);
      _lastWrapLimit = $scope.snapItParams.wrapLimit;
    };


    $scope.getPreview = function() {
      var params = _.clone($scope.snapItParams);
      var language = params.language;
      var theme = params.theme;
      params.language = SnapItLanguageService.findByEditorName(language).id;
      params.theme = SnapItThemeService.findByEditorName(theme).id;
      params.body = _editor.getValue();
      params.wrapLimit = $scope.snapItParams.isWrapEnabled ? +$scope.snapItParams.wrapLimit : null;

      SnapItProxyService.create(params)
        .then(function(response) {
          var $img = angular.element('<img>');
          $img.attr('class', 'img-responsive');
          $img.attr('src', 'data:image/jpeg;base64,' + response.image_data);
          angular.element('#snap-it-preview').html($img);
          angular.element('#snap-it-preview-modal').modal();
          $scope.snapItParams.token = response.token;
          console.log(response);
        }, function(response) {
          Flash.create('danger', response.data.error.join('<br>'));
          console.error(response);
        });
    };


    $scope.snapIt = "var foo = 'bar';\n\n" +
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.\n\n" +
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.\n\n" +
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.\n\n" +
    "Lorem ipsum dolor sit amet, con.\n\n" +
    "Lorem i\n\n" +
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.\n\n" +
    "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque sed aliquid possimus, autem, debitis error sit cumque molestias incidunt necessitatibus explicabo id fugiat illum quos minima. Nisi doloremque reiciendis natus.\n\n" +
    "Proc.new{ |i| i + 100 }\n\n" +
    "<?php $foo = 'bar' . 'baz';\n\n";

  }]);




