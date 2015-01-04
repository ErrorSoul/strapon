angular.module("admin").controller "DashboardCtrl", ["$scope", '$location', "sessionStorage", "Post", ($scope, $location, sessionStorage, Post) ->
  foo = (data) ->
    console.log("DATA !", data)
    #$scope.r = data
    $scope.posts = data.posts
  bar = (error) ->
    console.log("DATA !", error)
    #$scope.r = data
    
    
  Post.query().$promise.then(foo, bar)
    
    .then((data) ->
      console.log(data)
          
          
    )

  $scope.isDashboard = true
  $scope.delete = (idx) ->
    post_to_delete = $scope.posts[idx]
    Post.remove({id: post_to_delete.id}, (data) ->
      if data.message is "Your post deleted"
        $scope.message = data.message
        console.log(data, 'delete.data')
        #post_to_delete.hideValue = true)
        $scope.posts.splice(idx, 1))
        
  ]
