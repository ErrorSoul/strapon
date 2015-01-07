angular.module("post").controller "MountCtrl", ["$scope","$http",'$timeout', "$window", ($scope, $http, $timeout, $window) ->
  
  $scope.clicked = (cls) ->
    if cls is 'run'
      $scope.myVar1 = cls
    else
      $scope.myVar2 = cls
    changed = () ->
      if cls is "run"
        $scope.myVar1 = null
      else
        $scope.myVar2 = null
    $timeout(changed, 1000)
    
  $scope.tab = 1
  $scope.pusher = 0
  $scope.list_flag = false
  $scope.hide_flag = false
  $scope.changeList = ->
    $scope.list_flag  = !$scope.list_flag
  $scope.isList = ->
    return "list" if $scope.list_flag is true
  $scope.getCat = (ind) ->
    return ".category-#{ind}"

  $scope.is_asset = (asset) ->
    
    if not asset
      return "foo-bar"


  $scope.add_post = (post_id) ->
    return $scope.myVar = "new_class"
  
  $scope.pop_elem = () ->
    if $scope.flag
      $scope.p.splice(3,0, $scope.remove_element)
      $scope.flag = false
    else
      $scope.remove_element = $scope.p[3]
      $scope.p.splice(3, 1)
      $scope.flag = true
    
  $scope.add_elem = () ->
    $scope.p.splice(3,0, $scope.remove_element)
  $scope.newIsClass = (ind) ->
    return "Cont#{ind}"
  $scope.checkHide = ->
    $scope.hide_flag = !$scope.hide_flag
    console.log("SCOPE>HIDEFLAG", $scope.hide_flag)
  $scope.isHide= (ind)  ->
    if ind % 2 is 0
      if $scope.hide_flag is true
        return true


  $scope.change = ->
    $scope.p = $scope.posts[$scope.tab]
  $scope.getPat = (ind) ->
    return "category-#{ind}"

  $scope.isClass = (post) ->
    if post.id % 2 is 0
      return "category-1"
    else
      return "category-2"
  bar = ->
    foo($scope)
  extra = ->
    console.log($scope.posts, "NEWPOSTS")

  $scope.getTab = ->
    return $scope.tab

  $scope.addTab = ->
    $scope.tab = ($scope.tab + 1) % 6
    $scope.change()
  
    
    
    
  #$scope.posts = [1..10]
  #$timeout(bar, 5000)
  #console.log($scope.posts, "POSTS")
  #$timeout(extra, 6000)
  #angular.element('#Container').mixItUp()
  $scope.getClass = (ind) ->
    if $scope.tab is ind
      if $scope.tab is 2
        return "Xara"
      else
        return "Container"
    else
      return "Another"
  group_by_six = (posts) ->
    sliceLen = 6
    p = []
 
    for i in [0...posts.length] by sliceLen
      slice = posts[i...i+sliceLen]
      p.push(slice)
    return p 
  z = () ->
    angular.element("#Xara").mixItUp()
  callback = (data)->
    console.log(data)
  

 
  $http.get("/main_posts").success((data) ->
    delay_posts =  ->
      
      console.log("GROUP_BY_SIX", group_by_six(data.posts))
      $scope.posts = group_by_six(data.posts)
      $scope.p = $scope.posts[0]
    $timeout(delay_posts, 1000)
    
    #angular.element("#Container").mixItUp() 

    #$timeout(foo1,0)

    console.log(data)).error(callback)
          
          


 

        
  ]


`angular.module("post").directive('forceAnimationScope', function()
	{
	  return {
      restrict: 'A',
      link: function(scope, element, attributes) {
        element.data('$$ngAnimateKey', attributes.forceAnimationScope);
      }
	  };
	});`
	
