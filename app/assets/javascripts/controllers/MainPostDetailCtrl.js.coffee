angular.module("post").controller "MainPostDetailCtrl", ["$scope", '$log',"$http", "$location", "$window", "$timeout", "Comment", "commentUpload", 'commentTools',($scope,  $log, $http, $location, $window, $timeout, Comment, commentUpload, commentTools) ->
 
  $scope.id = $window.location.href.split("/").pop()
  ################################
  console.log($window.location.href, "location")
  $scope.b = 0
  commentTools.init()
  $scope.tool = commentTools
  $scope.add_limit = commentTools.add_limit
  $scope.binaryS = commentTools.binary_search

  
  $scope.take_comments = () ->
    Comment.show({id: $scope.id}, (data) ->
      $scope.date = Date.now()
      $scope.tool.arr = data.comments
      console.log($scope.tool.arr, "tool.arr")
      $timeout($scope.checkNew, 10000)
      console.log('data', data.comments))
  $timeout($scope.take_comments, 0)

  $scope.show  = ->
    $timeout ->
      $window.alert "hi!"
      return
    console.log($scope.my_answer, "MY ANSWER")
  
  $scope.twitter = () ->
    window.$windowScope = $scope
    #$window.open("/auth/twitter", "NAME", "width=420,height=230")
    child = window.open("/auth/twitter", "Aвторизация", "width=400, height=800")
    checkChild = ->
      console.log('checkchild')
      console.log("child", child)
      if child.closed
        window.alert("Child window closed")
        clearInterval timer
      return
    timer = setInterval(checkChild, 500)

    

    console.log($scope.my_answer, "MY ANSWER")
    
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
  $scope.get_offset = (num) ->
    if num >= 5
      return 4
    else
      return num - 1
  $scope.callbacka = (data) ->
    $scope.message = data.message
    commentTools.coma = data.comment
    console.log("data", data)

        
  $scope.send = (comment, n, post_id, ind)   ->
    commentTools.send(comment, n, post_id, ind,
                      $scope.callbacka, $scope.tool)
    
  
   #with eval
  toggle_moggle = (ind, n) ->
    inx = $scope.converter(ind, n)
    dict = {"Post": {flag: "$scope.p"}, "Comment": {flag: "$scope.tool.arr[ind].p"}}
    
    if eval(dict[n.type].flag) is false or eval(dict[n.type].flag) is undefined
       $scope.tool.arr.splice(inx , 0, {date: Date.now(), red: true, offset: 1, id: n.id, type: n.type})
       eval("#{dict[n.type].flag} = !eval(dict[n.type].flag)")
       
       
    else
       eval("#{dict[n.type].flag} = !eval(dict[n.type].flag)")
       #dict[n.type].flag = !dict[n.type].flag
       $scope.tool.arr.splice(inx, 1)

  #toggle without eval
  
  $scope.toggle_without_eval = (ind, n) ->
    $scope.tool.toggle_service(ind,n)
      
    
  
  $scope.checkNew = ->
    $http.get("/photos/#{$scope.date}").success((data) ->
      $scope.lena = $scope.tool.check_helper(data.comments)
      $scope.dara = true if $scope.lena > 0)
      #$timeout($scope.checkNew, 10000))
        .error((error) ->
          console.log(error)) 
    
  $scope.add = (ind, n) ->
    $scope.toggle_without_eval(ind, n)

  $scope.merge = ->
    mock_arr = $scope.tool.arr.slice(0)
    #don't clear new_arr
    # because new_arr respawn periodic
    console.log($scope.tool.new_arr, "NEW NEW ARRR")
    for comment in $scope.tool.new_arr
      mock_arr.push comment
    mock_arr.sortBy("path")
    $scope.tool.arr = mock_arr
    $scope.lena = 0
    $scope.date = Date.now()
  
  

    


  ]


 
