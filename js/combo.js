/**
 Class used for calling function, only when several async requests are finished. Usage:
 va exampleCombo = new CyclicBarrier(finalFunction, 3)
 exampleCombo.wrap(asyncFunction)
 exampleCombo.wrap(asyncFunction)
 exampleCombo.wrap(asyncFunction)
 ....
 Each function will have additional parameter sharedObject, that later will be passed to finalFunction.
 You can use it as a single context for this CyclicBarrier

 When all asyncFunctions are finished finalFunction will be called
 */
var CyclicBarrier = function(finishedHandler, length) {
	this.finishedHandler = finishedHandler || Onyx.emptyFunction;
	this.length = length;
	this.context = {};
	this.finishedOne = function() {
		this.length--;
	};
	this.setHandler = function(handler) {
		this.finishedHandler = handler
	};
	this.wrap = function(callback){
		var self = this;
		var _callback = (callback || Onyx.emptyFunction);
		return function(){
			self.finishedOne()
			arguments[ arguments.length++ ] = self.context;
			_callback.apply(null, arguments);
			if (self.isFinished()) {
				self.finishedHandler(self.context)
			}
		}
	};
	this.isFinished = function() {
		return this.length == 0;
	};

	return this;
};
var Onyx = function() {};
Onyx.prototype.emptyFunction = function(){};