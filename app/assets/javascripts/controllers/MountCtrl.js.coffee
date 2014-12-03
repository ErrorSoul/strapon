angular.module("post").controller "MountCtrl", ["$scope","$http",'$timeout', ($scope, $http, $timeout) ->
  $scope.isClass = (post) ->
    if post.id % 2 is 0
      return "category-1"
    else
      return "category-2"
  bar = ->
    foo($scope)
  extra = ->
    console.log($scope.posts, "NEWPOSTS")
    
  #$scope.posts = [1..10]
  #$timeout(bar, 5000)
  #console.log($scope.posts, "POSTS")
  #$timeout(extra, 6000)
  #angular.element('#Container').mixItUp()
  
  z = () ->
    angular.element("#Container").mixItUp()
  callback = (data)->
    console.log(data)

  foo1 = (scope) ->
  
 
    $ ->
      layout = "grid" # Store the current layout as a variable
      $container = $("#Container") # Cache the MixItUp container
      $changeLayout = $("#ChangeLayout") # Cache the changeLayout button
      
      # Instantiate MixItUp with some custom options:
      $container.mixItUp
        animation:
          animateChangeLayout: true # Animate the positions of targets as the layout changes
          animateResizeTargets: true # Animate the width/height of targets as the layout changes
          effects: "fade rotateX(-40deg) translateZ(-100px)"

        layout:
          containerClass: "grid" # Add the class 'list' to the container on load

      
      # MixItUp does not provide a default "change layout" button, so we need to make our own and bind it with a click handler:
      $changeLayout.on "click", ->
        
        # If the current layout is a list, change to grid:
        if layout is "list"
          layout = "grid"
          $changeLayout.text "List" # Update the button text
          $container.mixItUp "changeLayout",
            containerClass: layout # change the container class to "grid"

        
        # Else if the current layout is a grid, change to list:  
        else
          layout = "list"
          $changeLayout.text "Grid" # Update the button text
          $container.mixItUp "changeLayout",
            containerClass: layout # Change the container class to 'list'

        return

      return

    return
  foo = () ->
    $("#Container").mixItUp callbacks:
      onMixLoad: ->
        console.log "MixItUp ready!"
        $scope.posts = [
          1
          2
          3
          4
          5
          6
          7
          8
          9
        ]
        console.log "this is scope posts" + $scope.posts
        return

      onMixFail: ->
        console.log "No elements found matching"
        $scope.posts = [
          1
          2
          3
          4
          5
          6
          7
          8
          9
        ]
        return
  $http.get("/main_posts").success((data) ->
    $scope.posts = data.posts
    $timeout(foo1,2000)
    #angular.element("#Container").mixItUp() 

    
    console.log(data)).error(callback)
          
          


 

        
  ]



