angular.module("post").controller "MainPostDetailCtrl", ["$scope", '$log',"$location", "$window", "Comment", "commentUpload",($scope,  $log, $location, $window, Comment, commentUpload) ->
 
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
    $scope.coma = data.comment
    
    console.log("data", data)
    
  $scope.send = (comment, n, post_id, ind)   ->
    console.log("comment", comment)
    console.log("n_id", n.id)
    console.log("post_id", post_id)
    console.log("$COMMENT", $scope.comment)
    comment.post_id = post_id
    comment.commentable_id = n.id
    comment.commentable_type = n.type
    console.log("comment", comment)
    #Comment.create({comment: comment}, {}, $scope.callbacka, $scope.callbacka)
    commentUpload.createComment(comment, $scope.callbacka).$promise.then((response)->
      
      $scope.arr.splice(ind, 1)
      $scope.arr.splice(ind, 0, $scope.coma)
      if n.type is "Post"
        $scope.p = false
      else
        # (ind - 1) because change flag for parent comment
        # after create comment you add new item in arr
        # => ind is your ind, (ind-1) is your parent ind
        $scope.arr[ind - 1].p = false )
      #$scope.arr[ind] = $scope.comment)
  $scope.arr = ({id: c, offset: 0} for c in [1..10]) 
  $scope.converter = (ind,n) ->
    if ind is 0 and n.type is "Post"
      console.log("INDEX IS 0 AND TYPE IS POST")
      inx = 0
    else
      console.log("INDEX IS " + ind.toString())
      console.log("N.TYPE IS " + n.type)
      inx = ind + 1
    return inx


  #with eval
  toggle_moggle = (ind, n) ->
    inx = $scope.converter(ind, n)
    dict = {"Post": {flag: "$scope.p"}, "Comment": {flag: "$scope.arr[ind].p"}}
    console.log("NTYPE IS ", n.type)
    console.log("n IS ", n)
    console.log("DICT FLAG IS ", eval(dict[n.type].flag))
    if eval(dict[n.type].flag) is false or eval(dict[n.type].flag) is undefined
       $scope.arr.splice(inx , 0, {date: Date.now(), red: true, offset: 1, id: n.id, type: n.type})
       eval("#{dict[n.type].flag} = !eval(dict[n.type].flag)")
       console.log("AFTER DICT FLAG IS ", eval(dict[n.type].flag))
       console.log("AFTER DICT IS ", dict)
       console.log("AFTER SCOPE>P IS ", $scope.p)
       
    else
       eval("#{dict[n.type].flag} = !eval(dict[n.type].flag)")
       #dict[n.type].flag = !dict[n.type].flag
       $scope.arr.splice(inx, 1)

  #toggle without eval
  $scope.toggle_without_eval = (ind, n) ->
    inx = $scope.converter(ind, n)
    console.log("$SCOPE>P", $scope.p)
 
    if $scope.arr.length is 0
      tara = false
    else
      tara = $scope.arr[ind].p
    #console.log("$SCOPE.ARR[IND]>P", $scope.arr[ind].p)
    dict = {"Post": {flag: $scope.p}, "Comment": {flag: tara }}
    console.log("DICTIONARY", dict)
    if dict[n.type].flag is false or dict[n.type].flag is undefined
       $scope.arr.splice(inx , 0, {date: Date.now(), red: true, offset: 1, id: n.id, type: n.type})
       console.log("ARRAY AFTER ADD",$scope.arr )
    else
       $scope.arr.splice(inx, 1)
       console.log("ARRAY AFTER CUT",$scope.arr )
    if n.type is "Post"
      $scope.p = !$scope.p
      console.log("SCOPE>P is ", $scope.p)
    else
      $scope.arr[ind].p = !$scope.arr[ind].p
      console.log("SCOPE.ARRAY[ind]>P is ", $scope.arr[ind].p)
      
      
       
  $scope.add = (ind, n) ->
    #toggle_moggle(ind,n)
    $scope.toggle_without_eval(ind, n)
    
   
   
        
  ]


 
