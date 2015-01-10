angular.module("post").controller "CartCtrl", ["$scope","$http",'$timeout', 'commentTools',  ($scope, $http, $timeout, commentTools) ->

  $scope.group_by_six = commentTools.group_by_six

  callback = (data) ->
    $scope.posts = $scope.group_by_six(data.posts)
    $scope.tab_len = $scope.posts.length
    $scope.p = $scope.posts[0]
    $scope.tab = 0
    console.log("posts", $scope.posts)

  $scope.group_by_six = commentTools.group_by_six

  $http.get("/carts/1").success(callback)
    .error((error) ->
      console.log(error, "Error"))

  $scope.change = ->
    $scope.p = $scope.posts[$scope.tab]


  $scope.addTab = ->
    $scope.tab = ($scope.tab + 1) % $scope.tab_len
    $scope.change()

  $scope.subTab = ->
    $scope.tab = (($scope.tab - 1) + $scope.tab_len) % $scope.tab_len
    $scope.change()

]
