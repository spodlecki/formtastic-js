this.Formtastic ||= {}
this.Formtastic.Input ||= {}
this.Formtastic.Inputs ||= {}

###*
@class StringFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

class StringFieldHelper extends Formtastic.Input.Base
  constructor: (field, attributes, prefix)->
    super(field, attributes, prefix)

this.Formtastic.Input.StringFieldHelper = StringFieldHelper


###*
@for Formtastic
@method string_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
this.Formtastic.Inputs.string_field = (field, attrs)->
  attrs = _.extend({input_html: {}, attrs})
  attrs['input_html']['type'] ||= 'text'

  @input(field, attrs)