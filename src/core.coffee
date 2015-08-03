this.Formtastic ||= {}

FormtasticInput = {}
FormtasticInputs = {}
FormtasticHelpers = {}

extend = (src, dest)->
  for own key, fn of src
    dest.prototype[key] = fn

_.mixin
  isBlank: (object) ->
    switch typeof object
      when 'number' then _.isNaN(object)
      else _.isEmpty(object)
  isPresent: (object) ->
    !_.isBlank(object)
,
  chain: false