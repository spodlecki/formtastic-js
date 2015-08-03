###*
@class HiddenFieldHelper
@module Formtastic.Input
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###

this.Formtastic ||= {}
this.Formtastic.Inputs ||= {}

class HiddenFieldHelper extends Formtastic.Input.Base
  label: =>
    null

  wrapper: =>
    node = super
    node.style = "display: none;"
    node

this.Formtastic.Input.HiddenFieldHelper = HiddenFieldHelper


###*
@for Formtastic
@method string_field
@param field {String} Name of the field
@param attributes {Object} Field Attributes
###
this.Formtastic.Inputs.hidden_field = (field, attrs)->
  attrs = _.extend({as: 'hidden'}, attrs)
  @input(field, attrs)