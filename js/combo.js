/**
    Class used for calling function, only when several async requests are finished. Usage:
    va exampleCombo = new Combo(finalFunction, 3)
    asyncFunction(exampleCombo.add())
    asyncFunction(exampleCombo.add())
    asyncFunction(exampleCombo.add())
    ....
    When all asynFunctions are finished finalFunction will be called
    @requires prototype1.6.1
 */
var Combo = Class.create({
    initialize: function(finishedHandler, operationsCount){
		this.finishedHandler = null;
		this.length = 0;
		this.isDynamic = false;

        this.setHandler(finishedHandler);
        this.length = operationsCount || 0;
		if (this.length == 0) this.isDynamic = true;
    },
    setHandler: function(handler) {
        this.finishedHandler = handler;
    },
    add: function(callback){
        var self = this;
		if (this.isDynamic) this.length++;
        var _callback = (callback || Prototype.emptyFunction);
        return function(){
            self.finishedOne()
            _callback.apply(null, arguments)
            if (self.isFinished()) {
                self.finishedHandler()
            }
        }
    },
    finishedOne: function(){
        this.length--;
    },
    isFinished: function() {
        return this.length == 0;
    }
})
