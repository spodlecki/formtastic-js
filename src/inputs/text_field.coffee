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
@for Formtastic
@method text_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
@returns {Object} `ret.label` and `ret.input` are both html strings
###

window.Formtastic ||= {}
window.Formtastic.Inputs ||= {}

Formtastic.Inputs.text_field = (field, attributes)->
  attributes = _.extend(attributes, {input_html: {type: 'text'} })
  @input_field(field, attributes)