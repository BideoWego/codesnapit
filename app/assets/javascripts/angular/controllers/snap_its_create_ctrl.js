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
    SnapItService,
    SnapItProxyService,
    SnapItLanguageService,
    SnapItThemeService
  ) {

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
      title: 'Awesome',
      description: 'Dude!'
    };

    var _editor;

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

    $scope.createSnapIt = function() {
      // TODO pseudocode snapit creation from proxy

      SnapItService.create($scope.snapItParams)
        .then(function(response) {
          console.log(response);
        }, function(response) {
          console.error(response);
        });
    };


    // $scope.getPreview = function() {
    //   var url = 'http://localhost:3000/snap_it_proxy?token=cea7b4e9f0c5a308971ff8c77444bc22';

    //   $http({
    //     method: 'POST',
    //     url: 'http://localhost:4000/api/v1/screenshot',
    //     data: $httpParamSerializerJQLike({
    //       format: 'base64',
    //       url: url
    //     }),
    //     headers: {
    //       'Content-Type': 'application/x-www-form-urlencoded'
    //     }
    //   })
    //     .then(function(response) {
    //       var $img = angular.element('<img>');
    //       $img.attr('class', 'img-responsive');
    //       $img.attr('src', 'data:image/jpeg;base64,' + response.data);
    //       angular.element('#snap-it-preview').html($img);
    //       angular.element('#snap-it-preview-modal').modal();
    //       console.log(response);
    //     }, function(response) {
    //       console.error(response);
    //     });
    // };

    $scope.getPreview = function() {
      var params = _.clone($scope.snapItParams);
      var language = params.language;
      var theme = params.theme;
      params.language = SnapItLanguageService.findByEditorName(language).id;
      params.theme = SnapItThemeService.findByEditorName(theme).id;
      params.body = _editor.getValue();

      SnapItProxyService.create(params)
        .then(function(response) {
          var $img = angular.element('<img>');
          $img.attr('class', 'img-responsive');
          $img.attr('src', 'data:image/jpeg;base64,' + response.image_data);
          angular.element('#snap-it-preview').html($img);
          angular.element('#snap-it-preview-modal').modal();
          console.log(response);
        }, function(response) {
          console.error(response);
        });
    };


    $scope.snapIt = "var foo = 'bar';\n\n" +
    "Proc.new{ |i| i + 100 }\n\n" +
    "<?php $foo = 'bar' . 'baz';\n\n";

  }]);




