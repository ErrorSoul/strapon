angular.module("post").controller "MainPostDetailCtrl", ["$scope", '$log',"$location", "$window", "Comment", "commentUpload",($scope,  $log, $location, $window, Comment, commentUpload) ->
  $scope.b = false
  $scope.but = ->
    $scope.b = true
  $scope.id = $window.location.href.split("/").pop()
  console.log($scope.id, "SCOPEID")
  Comment.show({id: $scope.id}, (data) ->
    $scope.arr = data.comments
    console.log('data', data.comments))

  console.log($window.location.href, "location")
  $scope.flag = true
  $scope.isClass = ->
    if $scope.flag is true
      return "x"
    else
      return "non-x"
      
  $scope.changeClass = ->
    $scope.flag = !$scope.flag

  $scope.isRedClass = (ind) ->
    if ind.red
      return "red"
    else
      return "blue"
    
  $scope.callbacka = (data) ->
    $scope.message = data.message
    $scope.comment = data.comment
    
    console.log("data", data)
    
  $scope.send = (comment, n_id, post_id, ind)   ->
    console.log("comment", comment)
    console.log("n_id", n_id)
    console.log("post_id", post_id)
    console.log("$COMMENT", $scope.comment)
    comment.post_id = post_id
    comment.commentable_id = n_id
    comment.commentable_type = "Comment"
    console.log("comment", comment)
    #Comment.create({comment: comment}, {}, $scope.callbacka, $scope.callbacka)
    commentUpload.createComment(comment, $scope.callbacka).$promise.then((response)->
      $scope.arr.splice(ind, 1)
      $scope.arr.splice(ind, 0, $scope.comment) )
      #$scope.arr[ind] = $scope.comment)
  $scope.arr = ({id: c, offset: 0} for c in [1..10]) 

  $scope.add = (ind, n_id) ->
    
    $scope.arr.splice(ind + 1, 0, {date: Date.now(), red: true, offset: 1, id: n_id, type: "Comment"})
  
        
  ]
