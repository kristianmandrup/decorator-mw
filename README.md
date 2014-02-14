# Decorator Mw

Middleware to decorate a data object with class like behavior.

Works well with other middlewares from my *middleware* project

* middleware
* model-mw
* authorize-mw
* validator-mw
* marshaller-mw

## Usage

Simple example

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

DecorateMw = requires.file 'decorate-mw'

# create standalone decorator middleware instance
decorator-mw = new DecorateMw

# decorate person via decorator middleware instance
decorated-person = decorator-mw.run person
```

*Advanced example*

Using `klass` attribute to lookup "class" on client class repository.

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
app ||=
  decorators: new ContextDecorators

# register a decorator Person for the person model
app.decorators.set 'person', Person

# a simulated loaded data model for person
person =
  name: 'Joe 6 Pack'
  age: 28
  clazz: 'person' # identifies the model used for lookup in repo to find decorator

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
