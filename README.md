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
# Example: a Person constructor function which simply extends data object with some behavior
Person = (data-obj) ->
  lo.extend data-obj, {  
    fullName: ->
      [@firstName, @lastName].join ' '
  }
)

# Example: a Person blueprint object which extends data object with own state and behavior
Person =
  set-data: (data-obj)
    lo.extend @, data-obj

  fullName: ->
    [@firstName, @lastName].join ' '
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
decorations.register 'person', Person

decorated-person = decorations.decorate person
```

For more advanced cases, you might want to instantiate a different class given a particular app context (say 'admin' mode vs. 'guest' mode)

```LiveScript
Decorations = require('decorate-mw').CtxDecorations

ctx-decorations = new CtxDecorations

ctx-decorations.register 'guest', 'person', Person
ctx-decorations.register 'admin', 'person', AdminPerson

# can also be set via some "smart hash"
ctx-decorations.register 'admin', person: AdminPerson

# also allows a nicer DSL to achieve the same
ctx-decorations.for-model('person').register guest: GuestPerson, admin: AdminPerson

# get context, then decorate :)
# require person has a model or clazz attribute
decorated-person = ctx-decorations.ctx('admin').decorate person

# specifying decorator to use as optional 2nd arg: AdminPerson
decorated-person = ctx-decorations.ctx('admin').decorate person, 'AdminPerson'

# specifying decorator to use via Hash: super-admin-person
decorated-person = ctx-decorations.ctx('admin').decorate super-admin-person: person
```

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

# Example: using Class from jsclass as Decorator
Person = new Class(BaseModel,
  initialize: (obj) ->
    @callSuper!

  fullName: ->
    [@firstName, @lastName].join ' '
)

DecorateMw = requires.file 'decorate-mw'

# set middleware to be used when loading data from data storage (such as Racer.js)
load-mw-stack = new Middleware('model').use(decorate: DecorateMw)

# application decorators repo (used by default if none passed explicitly as argument)
app =
  decorators: new ContextDecorators

# register a decorator Person for the person model
app.decorators.register 'person', Person

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
