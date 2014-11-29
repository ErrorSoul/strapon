angular.module("post").controller "MountCtrl", ["$scope","$http", ($scope, $http) ->
  callback = (data)->
    console.log(data)
  $http.get("/posts").success((data) ->
    $scope.posts = data.posts
    console.log(data)).error(callback)
          
          


 

        
  ]
