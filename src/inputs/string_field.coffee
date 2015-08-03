###*
Build basic input with a given type.


```
object = {}
f = new Formtastic(object)
str = f.text_field()
// str.label => DOM String for label
// str.input => DOM String for Input
// str.wrapper => Attributes for wrapper (Object)
```
@class StringFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

class StringFieldHelper extends Formtastic.Input.Base
  constructor: (field, attributes, prefix)->
    super(field, attributes, prefix)

window.Formtastic.Input.StringFieldHelper = StringFieldHelper


###*
@for Formtastic
@method string_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
window.Formtastic.Inputs.string_field = (field, attrs)->
  attrs = _.extend({input_html: {}, attrs})
  attrs['input_html']['type'] ||= 'text'

  @input(field, attrs)