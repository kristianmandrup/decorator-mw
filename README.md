# Decorator Mw

Middleware to decorate a data object with class like behavior.

Works well with other mw-components for the *middleware* project

* [middleware](https://github.com/kristianmandrup/middleware)
* [model-mw](https://github.com/kristianmandrup/model-mw)
* [authorize-mw](https://github.com/kristianmandrup/authorize-mw)
* [validator-mw](https://github.com/kristianmandrup/validator-mw)
* [marshaller-mw](https://github.com/kristianmandrup/marshaller-mw)
* [racer-mw](https://github.com/kristianmandrup/racer-mw)

## Usage

The examples below assume the following

```LiveScript
# a Person "class", simply extend data object with some behavior
Person = (data-obj)->
  lo.extend data-obj, {  
    fullName: ->
      [@firstName, @lastName].join ' '
  }
)

# a simulated loaded data model for person
person =
  name: 'Joe 6 Pack'
  age: 28
  clazz: 'person' # identifies the model used for lookup in repo to find decorator
```

You should be able to use the Decorations repository directly like this:

```LiveScript
Decorations = require('decorate-mw').Decorations

decorations = new Decorations
decorations.set 'person', Person

decorated-person = decorations.decorate person
```

For more advanced cases, you might want to instantiate a different class given a particular app context (say 'admin' mode vs. 'guest' mode)

```LiveScript
Decorations = require('decorate-mw').CtxDecorations

ctx-decorations = new CtxDecorations

# you should also be able to set via some "smart hash"
ctx-decorations.set 'guest', 'person', Person
ctx-decorations.set 'admin', 'person', AdminPerson

# this would be a nicer DSL to achieve the same
ctx-decorations.for-model('person').set guest: GuestPErson, 'default': Person, admin: AdminPerson, 

# set context, then decorate :)
decorated-person = ctx-decorations.ctx('admin').decorate person
```

Note: Some of the above DSL notations are not yet available, please help implement them ;)

*Simple Mw example*

```LiveScript

DecorateMw = requires.file 'decorate-mw'

# create standalone decorator middleware instance
decorator-mw = new DecorateMw

# decorate person via decorator middleware instance
decorated-person = decorator-mw.run person
```

*Advanced example*

Using `clazz` attribute to lookup "class" on client class repository.

Loaded data object is decorated to become a Class instance:

```LiveScript
BaseModel           = requires.file 'base_model'
ContextDecorators   = require('decorator-mw').ContextDecorators

# example of using Class from jsclass library
Person = new Class(BaseModel,
  initialize: (obj) ->
    @callSuper!

  fullName: ->
    [@firstName, @lastName].join ' '
)

DecorateMw = requires.file 'decorate-mw'

# set middleware to be used when loading data from data storage (such as Racer.js)
load-mw-stack = new Middleware('model').use(decorate: DecorateMw)

# application decorators repo
app =
  decorators: new ContextDecorators

# register a decorator Person for the person model
app.decorators.set 'person', Person

# find and instantiate model class via decorate middleware
decorated-person = load-mw-stack.run person
```

## TODO

Improve test suite!

## Contribution

Please help out ;)

## License

MIT 2014
Copyright 2014 Kristian Mandrup
