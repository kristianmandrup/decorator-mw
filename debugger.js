// Generated by LiveScript 1.2.0
(function(){
  var lo;
  lo = require('lodash');
  module.exports = {
    debugging: false,
    debug: function(msg){
      var constr;
      if (this.debugging) {
        constr = this.constructor.displayName || this.displayName;
        console.log(constr + ':');
        return console.log.apply(this, arguments);
      }
    },
    debugOn: function(){
      return this.debugging = true;
    },
    debugOff: function(){
      return this.debugging = false;
    }
  };
}).call(this);
