###*
Create a URL Field (HTML5)
@for Formtastic
@method url_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
FormtasticHelpers.url_field = (field, attrs)->
  attrs = _.extend({as: 'url'}, attrs)
  @input(field, attrs, undefined, true)