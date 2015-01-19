
angular.module('admin').controller("PostDetailCtrl", ["$scope", "$timeout","sessionStorage",'$routeParams', "Post", "fileUpload", ($scope, $timeout,sessionStorage, $routeParams, Post, fileUpload) ->
  $scope.notNew = true
  Post.get({id: $routeParams.id, action: "edit" }, (data) ->
    $scope.post = data.post
    console.log('data', data.post)
    if data.post.asset
      $scope.asset_url = data.post.asset.url )

  $scope.uploadFileToUrl = fileUpload.uploadFileToUrl])
