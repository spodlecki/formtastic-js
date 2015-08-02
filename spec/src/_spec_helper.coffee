window.wrapper_class = (dom, css_class)->
  expect(dom.find('form li').hasClass(css_class)).toBeTruthy()

window.wrapper_id = (dom, id)->
  expect(dom.find('form li').attr('id')).toEqual id