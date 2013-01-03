/**
 Class used for calling function, only when several async requests are finished. Usage:
 var exampleCombo = new CyclicBarrier(finalFunction, 3)
 exampleCombo.wrap(asyncFunction)
 exampleCombo.wrap(asyncFunction)
 exampleCombo.wrap(asyncFunction)
 ....
 Each function will have additional parameter sharedObject, that later will be passed to finalFunction.
 You can use it as a single context for this CyclicBarrier

 When all asyncFunctions are finished finalFunction will be called
*/
'use strict';
(function (factory) {
	// Support three module loading scenarios
	if (typeof define === 'function' && define['amd']) {
		// [2] AMD anonymous module
		define(['jquery'], factory);
	} else {
		// [3] No module loader (plain <script> tag) - put directly in global namespace
		window.CyclicBarrier = factory(window.jQuery);
	}
})(function($) {
	var CyclicBarrier = function(finishedHandler, length) {
		var self = this;
		this.finishedHandler = finishedHandler || $.noop;
		this.length = length;
		this.context = {};
		this.finishedOne = function() {
			self.length--;
		};
		this.setHandler = function(handler) {
			self.finishedHandler = handler
		};
		this.wrap = function(callback){
			var _callback = (callback || $.noop);
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

	return CyclicBarrier;
})