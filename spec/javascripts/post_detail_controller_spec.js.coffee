describe "MainPostDetailCtrl", ->
  beforeEach(module('post'))
  beforeEach(inject(($injector, _$httpBackend_, $rootScope, $controller) ->
    @$httpBackend = _$httpBackend_
    
    @scope = $rootScope.$new()
    @ctrl = $controller('MainPostDetailCtrl', $scope: @scope)
    @service = $injector.get("Comment")
    @post = ({title: "Title 1", text: "Text 1", id: 1, type: "Post"})
    @comment = {id: 2, type: "Comment"}
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
          @scope.arr = []
          @scope.p = false
        it "when new post without comments should add to arr", ->
          @scope.toggle_without_eval(0, @post)
          expect(@scope.arr.length).toEqual(1)

         it "when new post without comments should change scope.p", ->
          @scope.toggle_without_eval(0, @post)
          expect(@scope.p).toEqual(true)

        it "when double add should change @scope.p to false", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.p).toEqual(false)

        it "when double add should delete from arr", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.arr.length).toEqual(0)
    
      describe "$scope.arr is not empty", ->
        beforeEach ->
          @scope.arr = [@comment]
          @scope.p = false
        it "when add comments to post", ->
          @scope.toggle_without_eval(0, @post)
          expect(@scope.arr.length).toEqual(2)

        it "when add comments to comment", ->
          @scope.toggle_without_eval(0, @comment)
          expect(@scope.arr.length).toEqual(2)

        it "when add comments to comment", ->
          @scope.toggle_without_eval(0, @comment)
          expect(@scope.arr[0].p).toEqual(true)

        it "when click double reply to post", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.arr.length).toEqual(1)
          expect(@scope.p).toEqual(false)
          expect(@scope.arr[0].p).toEqual(undefined)

        it "when click double reply to post", ->
          @scope.toggle_without_eval(0, @comment)
          @scope.toggle_without_eval(0, @comment)
          expect(@scope.arr.length).toEqual(1)
          expect(@scope.p).toEqual(false)
          expect(@scope.arr[0].p).toEqual(false)

        it "when click post, comment", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(1, @comment)
          expect(@scope.arr.length).toEqual(3)
          expect(@scope.p).toEqual(true)
          expect(@scope.arr[1].p).toEqual(true)

        it "when click comment, post", ->
          @scope.toggle_without_eval(0, @comment)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.arr.length).toEqual(3)
          expect(@scope.p).toEqual(true)
          expect(@scope.arr[1].p).toEqual(true)

        it "when click post, comment, post", ->
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(1, @comment)
          @scope.toggle_without_eval(0, @post)
          expect(@scope.arr.length).toEqual(2)
          expect(@scope.p).toEqual(false)
          expect(@scope.arr[0].p).toEqual(true)

        it "when click comment, post, comment", ->
          @scope.toggle_without_eval(0, @comment)
          @scope.toggle_without_eval(0, @post)
          @scope.toggle_without_eval(1, @comment)
          expect(@scope.arr.length).toEqual(2)
          expect(@scope.p).toEqual(true)
          expect(@scope.arr[1].p).toEqual(false)
          
            

         
      
  

 
