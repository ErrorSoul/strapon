angular.module("post").controller "MainPostDetailCtrl", ["$scope", '$log',"$http", "$location", "$window", "$timeout", "Comment", "commentUpload",($scope,  $log, $http, $location, $window, $timeout, Comment, commentUpload) ->
 
  $scope.id = $window.location.href.split("/").pop()
  console.log($scope.id, "SCOPEID")
  $scope.arr = []
  $scope.container = []
  $scope.count = 0
  $scope.b = 0
  $scope.DF= 50
  $scope.add_limit = ->
    $scope.DF += 50
  $scope.aran = ->
    if $scope.b < 800
      
      $scope.b += 101
      Array::push.apply $scope.arr, $scope.mock_arr[$scope.b..$scope.b + 100]
      $timeout($scope.aran, 10)
  $scope.r = () ->
    Comment.show({id: $scope.id}, (data) ->
      $scope.date = Date.now()
      console.log("date", $scope.date)
      #$scope.mock_arr = data.comments
      $scope.mock_arr = [1..1000]
      $scope.komments = data.comments
      #$scope.arr = data.comments
      $scope.arr = $scope.mock_arr
      #scope.aran()
      $timeout($scope.checkNew, 10000)
      console.log('data', data.comments))
  $timeout($scope.r, 0)
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
      $scope.container.push $scope.coma
      #$scope.date = Date.now()
      
      $scope.count -= 1
      if n.type is "Post"
        $scope.p = false
      else
        # (ind - 1) because change flag for parent comment
        # after create comment you add new item in arr
        # => ind is your ind, (ind-1) is your parent ind
        $scope.arr[ind - 1].p = false )
      #$scope.arr[ind] = $scope.comment)
  #$scope.arr = ({id: c, offset: 0} for c in [1..10]) 
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
       $scope.count += 1
       $scope.arr.splice(inx , 0, {date: Date.now(), red: true, offset: 1, id: n.id, type: n.type})
       console.log("ARRAY AFTER ADD",$scope.arr )
    else
       $scope.count -= 1
       $scope.arr.splice(inx, 1)
       console.log("ARRAY AFTER CUT",$scope.arr )
    if n.type is "Post"
      $scope.p = !$scope.p
      console.log("SCOPE>P is ", $scope.p)
    else
      $scope.arr[ind].p = !$scope.arr[ind].p
      console.log("SCOPE.ARRAY[ind]>P is ", $scope.arr[ind].p)
      
  cmp = (a, b) -> if a > b then 1 else if a < b then -1 else 0
 
  Array::sortBy = (key) ->
    @sort (a, b) ->
      [av, bv] = [a[key], b[key]]
      #[av, bv] = [av.toLowerCase(), bv.toLowerCase()] if options.lower
      cmp av, bv    
  check_helper = (comments) ->
    console.log("CHECK HELPER START")
    console.log("CHECK HELPER COMMENTS", comments)
   
    count = 0
    console.log("COUNT 0" , count )
    
    $scope.new_arr = []
    e = []
    sorted_x = (x,y) ->
      return x.path > y.path
    #d = $scope.arr.sort()
    #d = $scope.arr.sort((x,y) -> return x.path > y.path)
    d = $scope.arr.sortBy("path")
    for zar in d
      e.push zar.path
    
    console.log(d, "FFF")
    console.log($scope.mock_arr, "MOCK")
    console.log(e, "E CONT")
    for comment in comments
      console.log("COMMENT", comment)
      console.log("COMMENT.PATH", comment.path)
      console.log("FIND INDEX", $scope.binaryS(d, comment.path))
      if $scope.binaryS(d, comment.path) is -1
        count += 1
        console.log("COUNT CURRENT" , count )
        $scope.new_arr.push comment
    console.log("LENA" , $scope.lena )
    $scope.lena = count
    console.log("LENA" , $scope.lena )
    return count
  $scope.checkNew = ->
    console.log("YYYYYYYYYY")
    $http.get("/photos/#{$scope.date}").success((data) ->
      #$scope.new_arr = data.comments
      check_helper(data.comments)
      console.log("current Date", $scope.date)
      #$scope.lena = data.comments.length
      $scope.dara = true if $scope.lena > 0
      console.log("length", $scope.lena)
      $timeout($scope.checkNew, 10000))
        .error((error) ->
          console.log(error)) 
    #$http.get("/comments/#{$scope.id}").success((data) ->
    #  $scope.new_arr = data.comments
    #  $scope.lena = $scope.new_arr.length - ($scope.arr.length - $scope.count)
    #  $scope.dara = true if $scope.lena > 0
    #  $timeout($scope.checkNew, 5000))
    #    .error((error) ->
    #      console.log(error))  
  $scope.add = (ind, n) ->
    #toggle_moggle(ind,n)
    $scope.toggle_without_eval(ind, n)
    
  $scope.arra = [1..1000]

  $scope.binaryS = (arr, searchElement) ->
    console.log("SEARCH ELEMENT IS", searchElement)
    "use strict"
    minIndex = 0
    maxIndex = arr.length - 1
    
    while minIndex <= maxIndex
      currentIndex = (minIndex + maxIndex) / 2 | 0
      currentElement = arr[currentIndex].path
      if currentElement < searchElement
        minIndex = currentIndex + 1
      else if currentElement > searchElement
        maxIndex = currentIndex - 1
      else
        return currentIndex
    -1
  
  $scope.merge = ->
    console.log("URBECH")
    $scope.date = Date.now()
    a = new JS.Set($scope.new_arr)
    b = new JS.Set( $scope.arr)

    a.difference(b)
    $scope.diff = $scope.new_arr - $scope.arr
    console.log($scope.diff, "DIFF")
    #$scope.arr = $scope.new_arr
    if $scope.diff > 0
      console.log($scope.diff, "DIFF")
      $scope.arr.splice(2, 0, item ) for item in $scope.diff


  $scope.ch = () ->
    console.log("CHANGE---           CHange")
    $scope.arr = $scope.komments
  ]


 
