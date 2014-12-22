angular.module("post").controller "MainPostDetailCtrl", ["$scope", ($scope) ->

  $scope.flag = true
  $scope.isClass = ->
    if $scope.flag is true
      return "x"
    else
      return "non-x"
      
  $scope.changeClass = ->
    $scope.flag = !$scope.flag

        
  ]
