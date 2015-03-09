
angular.module('admin').controller("PostDetailCtrl", ["$scope","$sce", "$timeout","sessionStorage",'$routeParams', "Post", "fileUpload", ($scope, $sce, $timeout,sessionStorage, $routeParams, Post, fileUpload) ->
  $scope.notNew = true
  Post.get({id: $routeParams.id, action: "edit" }, (data) ->
    $scope.post = data.post
    console.log('data', data.post)
    if data.post.asset
      $scope.asset_url = data.post.asset.url )
  
  $scope.t =  ->
    if $scope.post
      $sce.trustAsHtml $scope.post.text if $scope.post.text
  $scope.uploadFileToUrl = fileUpload.uploadFileToUrl])
 
