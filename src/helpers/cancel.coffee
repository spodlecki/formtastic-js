###*
Generates Cancel Button
@for Formtastic
@method cancel
@param text {String} Button / Input Value
@param attrs {Object} Action Input Attributes
###

FormtasticHelpers.cancel = (text, attrs)->
  cfg = _.extend({label: text}, attrs)
  @action('cancel', cfg)