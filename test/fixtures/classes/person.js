// Generated by LiveScript 1.2.0
(function(){
  var requires, Class, BaseModel, Person, exports;
  requires = require('../../../requires');
  Class = require('jsclass/src/core').Class;
  BaseModel = requires.lib('base_model');
  Person = new Class(BaseModel, {
    initialize: function(obj){
      return this.callSuper();
    },
    fullName: function(){
      return [this.firstName, this.lastName].join(' ');
    }
  });
  exports = module.exports = Person;
}).call(this);