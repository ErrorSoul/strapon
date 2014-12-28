describe "MainPostDetailCtrl", ->
  beforeEach(module('post'))
  beforeEach(inject(($injector, _$httpBackend_, $rootScope, $controller) ->
    @$httpBackend = _$httpBackend_
    
    @scope = $rootScope.$new()
    @ctrl = $controller('MainPostDetailCtrl', $scope: @scope)
    @service = $injector.get("Comment")
    @post = ({title: "Title 1", text: "Text 1", id: 1, type: "Post", path: "0"})
    @comment = {id: 2, type: "Comment", path: "1"}
    ))

 

  
  describe "MainPostDetailCtrl", ->
    describe "converter", ->
      it "should return 0 when type is Post", ->
        expect(@scope.converter(0, @post)).toEqual(0)


      it "should return 2 when type is Post and ind is 1", ->
        expect(@scope.converter(1, @post)).toEqual(2)


      it "should return 1 when type is Comment and ind is 0", ->
        expect(@scope.converter(0, @comment)).toEqual(1)

      it "should return 2 when type is Comment and ind is 1", ->
        expect(@scope.converter(1, @comment)).toEqual(2)

    describe "toggle without eval", ->
      describe "$scope.arr is empty arr", ->
        beforeEach ->
          @scope.tool.arr = []
          @scope.tool.p = false
        it "when new post without comments should add to arr", ->
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.arr.length).toEqual(1)

         it "when new post without comments should change scope.p", ->
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.p).toEqual(true)

        it "when double add should change @scope.tool.p to false", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.p).toEqual(false)

        it "when double add should delete from arr", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.arr.length).toEqual(0)

        describe "path implementation", ->
        
          it "when click post child path should equal 0", ->
            @scope.toggle_without_eval(0, @post)
            expect(@scope.tool.arr[0].path).toEqual("0")

          it "when click comment child path should equal 'parent.path' + '.0' ", ->
            @scope.toggle_without_eval(0, @post)
            @scope.toggle_without_eval(0, @comment)
            expect(@scope.tool.arr[0].path).toEqual("0")
            expect(@scope.tool.arr[1].path).toEqual("1.0")
    
      describe "$scope.arr is not empty", ->
        beforeEach ->
          @scope.tool.arr = [@comment]
          @scope.tool.p = false
        it "when add comments to post", ->
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.arr.length).toEqual(2)

        it "when add comments to comment", ->
          @scope.toggle_without_eval(0, @comment)
          expect(@scope.tool.arr.length).toEqual(2)

        it "when add comments to comment", ->
          @scope.toggle_without_eval(0, @comment)
          expect(@scope.tool.arr[0].p).toEqual(true)

        it "when click double reply to post", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.arr.length).toEqual(1)
          expect(@scope.tool.p).toEqual(false)
          expect(@scope.tool.arr[0].p).toEqual(undefined)

        it "when click double reply to post", ->
          @scope.toggle_without_eval(0, @comment)
          @scope.toggle_without_eval(0, @comment)
          expect(@scope.tool.arr.length).toEqual(1)
          expect(@scope.tool.p).toEqual(false)
          expect(@scope.tool.arr[0].p).toEqual(false)

        it "when click post, comment", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(1, @comment)
          expect(@scope.tool.arr.length).toEqual(3)
          expect(@scope.tool.p).toEqual(true)
          expect(@scope.tool.arr[1].p).toEqual(true)

        it "when click comment, post", ->
          @scope.toggle_without_eval(0, @comment)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.arr.length).toEqual(3)
          expect(@scope.tool.p).toEqual(true)
          expect(@scope.tool.arr[1].p).toEqual(true)

        it "when click post, comment, post", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(1, @comment)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.tool.arr.length).toEqual(2)
          expect(@scope.tool.p).toEqual(false)
          expect(@scope.tool.arr[0].p).toEqual(true)

        it "when click comment, post, comment", ->
          @scope.toggle_without_eval(0, @comment)
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(1, @comment)
          expect(@scope.tool.arr.length).toEqual(2)
          expect(@scope.tool.p).toEqual(true)
          expect(@scope.tool.arr[1].p).toEqual(false)

        ##################
    
    describe "send method", ->
      describe "response method", -> 
        beforeEach ->
          @scope.tool.arr = [@comment]
          #@scope.tool.arr[0].p = false
          
          
        describe "add comment", ->
          beforeEach ->
          
          
            @scope.toggle_without_eval(0, @comment)
            @scope.tool.promise_handler( {type: "Comment"}, 1,@scope.tool)
            console.log("FFFF", @scope.tool.arr)
          it "should return arr length equal 2 ", ->
            
            expect(@scope.tool.arr.length).toEqual(2)

          it "should return count = 0 ", ->
            
            expect(@scope.tool.count).toEqual(0)

          it "should return all flags false ", ->
            
            expect(@scope.tool.p).toEqual(false)
            expect(@scope.tool.arr[0].p).toEqual(false)

          it "should return array p equal true after add new form comment ", ->
            @scope.toggle_without_eval(0, @comment)
            expect(@scope.tool.p).toEqual(false)
            expect(@scope.tool.arr[0].p).toEqual(true)
      

      describe "response method with Post", -> 
        beforeEach ->
          @scope.tool.arr = []
          #@scope.tool.arr[0].p = false
        describe "add comment to Post", ->
          it "should return $scope.tool.p is false", ->
            @scope.toggle_without_eval(0, @post)
            @scope.tool.promise_handler( {type: "Post"},0,@scope.tool)
            expect(@scope.tool.p).toEqual(false)
            expect(@scope.tool.count).toEqual(0)
            expect(@scope.tool.arr.length).toEqual(1)
            
          
      
        
          
            

        
        
      
  

 
