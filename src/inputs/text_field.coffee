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
@class TextFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

class TextFieldHelper extends Formtastic.Input.Base
  constructor: (field, attributes, prefix)->
    super(field, attributes, prefix)

window.Formtastic.Input.TextFieldHelper = TextFieldHelper


###*
@for Formtastic
@method text_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
window.Formtastic.Inputs.text_field = (field, attrs)->
  attrs = _.extend({input_html: {}, attrs})
  attrs['input_html']['type'] = 'text'
  @input(field, attrs)