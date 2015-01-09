angular.module("post").controller "MountCtrl", ["$scope","$http",'$timeout', "$window", ($scope, $http, $timeout, $window) ->
  
  $scope.clicked = (cls, ind) ->
    if cls is 'run'
      $scope.myVar1 = cls
    else
      $scope.p[ind].myVar = cls
    changed = () ->
      if cls is "run"
        $scope.myVar1 = null
      else
        $scope.p[ind].myVar = null
    $timeout(changed, 1000)
    
  $scope.tab = 0
 
  $scope.power_flag = false
  $scope.power_off = () ->
    $scope.power_flag = !$scope.power_flag
  
  $scope.is_asset = (asset) ->
    
    if not asset
      return "foo-bar"

  success_callback = (data) ->
    if data.message and data.message is "OK"
      $scope.z = true
      
  $scope.add_post = (post_id, cls, ind) ->
    $http.post('line_items', line_item: { post_id: post_id})
      .success(success_callback).error((error) ->
        console.log("error", error))
    if $scope.z
      $scope.clicked(cls, ind)
    
  
 
  $scope.change = ->
    $scope.p = $scope.posts[$scope.tab]
  

  
  bar = ->
    foo($scope)
  extra = ->
    console.log($scope.posts, "NEWPOSTS")

  $scope.getTab = ->
    return $scope.tab

  $scope.addTab = ->
    $scope.tab = ($scope.tab + 1) % $scope.tab_len
    $scope.change()

  $scope.subTab = ->
    $scope.tab = (($scope.tab - 1) + $scope.tab_len) % $scope.tab_len
    $scope.change()
  
    
    
    
  #$scope.posts = [1..10]
  #$timeout(bar, 5000)
  #console.log($scope.posts, "POSTS")
  #$timeout(extra, 6000)
  #angular.element('#Container').mixItUp()
  
  group_by_six = (posts) ->
    sliceLen = 6
    p = []
 
    for i in [0...posts.length] by sliceLen
      slice = posts[i...i+sliceLen]
      p.push(slice)
    return p 
 
  callback = (data)->
    console.log(data)
  

 
  $http.get("/main_posts").success((data) ->
    delay_posts =  ->
      
      console.log("GROUP_BY_SIX", group_by_six(data.posts))
      $scope.posts = group_by_six(data.posts)
      $scope.tab_len = $scope.posts.length
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
	
