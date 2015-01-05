angular.module("post").service('commentTools', ["$http","$window","$timeout","commentUpload", class Tool

  constructor: (@http, @window, @timeout, @commentUpload) ->
    @scope_id = ""
    @container = []
    @count = 0
    @b = 0
    @p = false
    @arr = []
    @DF = 50
    @flag = true

  init: () ->
    @scope_id = @window.location.href.split("/").pop()
    @container = []
    @count = 0
    @b = 0
    @DF = 50
    @p = false
    @arr = []
    @flag = true
    cmp = (a, b) ->
      if a > b then 1 else if a < b then -1 else 0
 
    Array::sortBy = (key) ->
      @sort (a, b) ->
        [av, bv] = [a[key], b[key]]
        #[av, bv] = [av.toLowerCase(), bv.toLowerCase()] if options.lower
        cmp av, bv  

  add_limit: () ->
    @DF += 50
    

  create_comment: (comment, n, post_id) ->
    #console.log("comment", comment)
    #console.log("n_id", n.id)
    #console.log("post_id", post_id)
    #console.log("$COMMENT", $scope.comment)
    comment.post_id = post_id
    comment.commentable_id = n.id
    comment.commentable_type = n.type
    console.log("comment", comment)
    return comment
  converter: (ind,n) ->
    if ind is 0 and n.type is "Post"
      console.log("INDEX IS 0 AND TYPE IS POST")
      inx = 0
    else
      console.log("INDEX IS " + ind.toString())
      console.log("N.TYPE IS " + n.type)
      inx = ind + 1
    return inx

  create_path: (path) ->
    if path is "0"
      return "0"
    else
      return path + ".0"

  
  name_to_reply: (num) ->
    if num.user_id is null
      return "Anonymous"
    else
       return num.user.name
      
  toggle_service: (ind, n) ->
    inx = @converter(ind, n)
    #create_path = $scope.tool.create_path
    dict =
          "Post": {flag: @p}
          "Comment": {flag: @create_flag(@arr, ind) }
    console.log("DICTIONARY", dict)
    if dict[n.type].flag is false or dict[n.type].flag is undefined
       @count += 1
       #@editor = new MediumEditor('.editable')
       @arr.splice(inx , 0, {
         date: Date.now(),
         red: true,
         offset: 1,
         name: n.name,
         id: n.id,
         type: n.type,
         path: @create_path(n.path)})
       @DF += 1
       b = @arr[inx]
       eee = () ->
        editor = new MediumEditor('.editable' )
       @timeout(eee, 0)
       console.log("ARRAY AFTER ADD", @arr )
    else
       @count -= 1
       @arr.splice(inx, 1)
       @DF -= 1
       editor = null
       console.log("ARRAY AFTER CUT", @arr )
    if n.type is "Post"
      @p = !@p
      console.log("SCOPE>P is ", @p)
    else
      @arr[ind].p = !@arr[ind].p
      console.log("SCOPE.ARRAY[ind]>P is ", @arr[ind].p)
  check_helper: (comments) =>
    #add new comments to new_arr
    # return count of new comments
    console.log("CHECK HELPER START")
    console.log("CHECK HELPER COMMENTS", comments)
    count = 0
    @new_arr = []
    mock_arr = @arr.slice(0)
    sorted_mock = mock_arr.sortBy("path")
    for comment in comments
      if @binary_search(sorted_mock, comment.path) is -1
        count += 1
        @new_arr.push comment
    return count

  binary_search: (arr, searchElement) ->
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
  create_flag: (arr, ind) ->
    if arr.length is 0
      return false
    else
      return arr[ind].p
  promise_handler: (n, ind, tool) ->
    console.log("@arr", tool.arr)
    tool.arr.splice(ind, 1)
    tool.arr.splice(ind, 0, tool.coma)
    tool.count -= 1
    console.log("@count", tool.count)
    console.log("$scope.tool.count", tool.count)
    if n.type is "Post"
      tool.p = false
    else
      # (ind - 1) because change flag for parent comment
      # after create comment you add new item in arr
      # => ind is your ind, (ind-1) is your parent ind
      tool.arr[ind - 1].p = false
    
  send: (comment, n, post_id, ind, callbacka, tool) =>
    update_comment = @create_comment(comment, n, post_id)
    @commentUpload.createComment(update_comment, callbacka)
      .$promise.then((response) =>
        @promise_handler(n, ind, tool))
])
