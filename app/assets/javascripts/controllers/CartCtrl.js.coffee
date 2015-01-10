angular.module("post").controller "CartCtrl", ["$scope","$http",'$timeout', 'commentTools',  ($scope, $http, $timeout, commentTools) ->

  $scope.group_by_six = commentTools.group_by_six

  callback = (data) ->
    if data.posts.length >  0
      $scope.full_flag = true
    else
      $scope.full_flag = false
    
    $scope.posts = $scope.group_by_six(data.posts)
    $scope.tab_len = $scope.posts.length
    $scope.p = $scope.posts[0]
    $scope.tab = 0
    console.log("posts", $scope.posts)
  error_callback =  (error) ->
    console.log(error, "Error")
  $scope.group_by_six = commentTools.group_by_six

  $http.get("/carts/1").success(callback)
    .error(error_callback)


  ######################
  ## posts page  control
  #
  #

  $scope.change = ->
    $scope.p = $scope.posts[$scope.tab]


  $scope.addTab = ->
    $scope.tab = ($scope.tab + 1) % $scope.tab_len
    $scope.change()

  $scope.subTab = ->
    $scope.tab = (($scope.tab - 1) + $scope.tab_len) % $scope.tab_len
    $scope.change()

  ##############
  #
  #

  $scope.clean_cart = () ->
    success_callback = ->
      for c, ind in $scope.posts
        $scope.posts[ind] = []
      $scope.change()
      $scope.empty_flag = true
      
    $http.delete("carts/1").success(success_callback)
      .error(error_callback)
    
    
  
  $scope.delete_post = (post_id, ind) ->
    destroy_callback = (data) ->
      if data.message and data.message is "Line item deleted"
        $scope.p.splice(ind, 1)
        console.log("post deleted")
    $http.delete("/line_items/#{post_id}").success(destroy_callback)
      .error(error_callback)

]
