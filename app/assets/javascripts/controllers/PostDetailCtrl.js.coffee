
angular.module('admin').controller("PostDetailCtrl", ["$scope","$sce", "$timeout","sessionStorage",'$routeParams', "Post", "fileUpload", ($scope, $sce, $timeout,sessionStorage, $routeParams, Post, fileUpload) ->
  $scope.notNew = true
  Post.get({id: $routeParams.id, action: "edit" }, (data) ->
    $scope.post = data.post
    $scope.r = $sce.trustAsHtml $scope.post.text
    console.log('data', data.post)
    if data.post.asset
      $scope.asset_url = data.post.asset.url )
  
  $scope.t =  ->
    $sce.trustAsHtml $scope.post.text
  $scope.uploadFileToUrl = fileUpload.uploadFileToUrl])
