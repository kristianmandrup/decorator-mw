// Generated by LiveScript 1.2.0
(function(){
  var type, ObjDecorator, ServerSerializer;
  type = require('./type');
  ObjDecorator = require('../../obj_decorator');
  module.exports = ServerSerializer = (function(superclass){
    var prototype = extend$((import$(ServerSerializer, superclass).displayName = 'ServerSerializer', ServerSerializer), superclass).prototype, constructor = ServerSerializer;
    function ServerSerializer(model, context){
      this.model = model;
      this.context = context;
      ServerSerializer.superclass.apply(this, arguments);
    }
    prototype.serialize = function(){
      this.propertiesOnly();
      return this.model;
    };
    prototype.propertiesOnly = function(){
      return Object.keys(this.model).filter(function(key){
        return type(this[key]) !== 'function';
      });
    };
    return ServerSerializer;
  }(ObjDecorator));
  function extend$(sub, sup){
    function fun(){} fun.prototype = (sub.superclass = sup).prototype;
    (sub.prototype = new fun).constructor = sub;
    if (typeof sup.extended == 'function') sup.extended(sub);
    return sub;
  }
  function import$(obj, src){
    var own = {}.hasOwnProperty;
    for (var key in src) if (own.call(src, key)) obj[key] = src[key];
    return obj;
  }
}).call(this);
