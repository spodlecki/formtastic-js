###*
@for Formtastic
@method reset
@param text {String} Button / Input Value
@param attrs {Object} Action Input Attributes
###

FormtasticHelpers.reset = (text, attrs)->
  cfg = _.extend({label: text}, attrs)
  @action('reset', cfg)