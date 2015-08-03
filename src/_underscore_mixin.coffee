_.mixin
  isBlank: (object) ->
    switch typeof object
      when 'number' then _.isNaN(object)
      else _.isEmpty(object)
  isPresent: (object) ->
    !_.isBlank(object)
,
  chain: false