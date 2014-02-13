requires  = require '../../../requires'
requires.clazz 'person'

module.exports = 
  classes.person: (data) ->
    new Person data