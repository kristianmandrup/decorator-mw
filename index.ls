rek       = require 'rekuire'
requires  = rek 'requires'

module.exports =
  DecoratorMw     :  requires.file 'decorator-mw'
  Decorations     :  requires.file 'decorations'
  CtxDecorations  :  requires.file 'context_decorations'
  BaseModel       :  requires.file 'base_model'

