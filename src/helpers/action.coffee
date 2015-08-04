###*
Generates Action Buttons (submit, reset, cancel)

@for Formtastic
@method action
@param type {String} submit|reset|cancel|commit
@param attrs {Object} Action Input Attributes
###

FormtasticHelpers.action = (type, attrs)->
  attrs = _.extend({}, attrs)
  attrs = _.extend(attrs, attrs.button_html)
  attrs = _.extend(attrs, attrs.input_html)
  delete attrs.button_html
  delete attrs.input_html

  type = ((type)->
    type = type or ''

    switch type.toLowerCase()
      when 'reset', 'submit', 'cancel'
        type.toLowerCase()
      else
        undefined
  )(type)

  throw new Error("Type required for action. submit|reset|cancel|commit") unless type

  text = ((text, attrs)->
    if attrs and attrs.label
      attrs.label
    else if text
      Formtastic.humanize(text)
  )(type, attrs)

  tag = ((attrs, type)->
    as = attrs and attrs.as
    switch as
      when 'button', 'input'
        as
      when 'btn'
        'button'
      when 'link'
        'a'
      else
        switch type
          when 'reset','submit'
            'input'
          when 'cancel'
            'a'
  )(attrs, type)

  validate = ((type, tag)->
    if type == 'submit' and tag == 'a'
      false
    else if type == 'cancel' and (tag == 'input' or tag == 'button')
      false
    else
      true
  )(type, tag)

  throw new Error("Unsupported :as for '"+type+"'") unless validate
  cfg = _.extend({tag: tag, type: type}, attrs)
  if tag == 'a'
    delete cfg.type
  delete cfg.as

  ele = @createNode(cfg, true)

  if tag == 'button'
    ele.innerHTML = text
  else if tag == 'a'
    ele.innerHTML = text
    ele.href = (attrs and attrs.href) or "javascript:window.history.back();"
  else
    ele.value = text

  ele.outerHTML