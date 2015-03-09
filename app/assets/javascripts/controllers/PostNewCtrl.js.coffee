angular.module("admin").controller "PostNewCtrl", ["$scope",'$timeout', "sessionStorage", '$routeParams', "Post", "fileUpload", ($scope, $timeout, sessionStorage,  $routeParams, Post, fileUpload) ->
  $scope.post = {}
  $scope.post.title = "Введи свой заголовок"
  $scope.post.text = "Введи свой текст"
  $scope.isNewPost = true
  $scope.uploadFileToUrl = fileUpload.createPost
  $scope.r = ->
    $scope.editor.deactivate()
    $scope.editor.activate()
  #$timeout($scope.r, 1000)
  $scope.showPopover = () ->
    rect = document.getElementById('title').getBoundingClientRect()
    document.getElementById('pop-id').style.right = rect.right
    $scope.flag = !$scope.flag
   


  ]
