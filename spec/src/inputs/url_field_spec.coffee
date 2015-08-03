describe '#url', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('random_href', as: 'url'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'url')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_random_href_input')
    itBehavesLike('label_with_text', 'Random Href')
    itBehavesLike('input_with_', 'id', 'blog_random_href')
    itBehavesLike('input_with_', 'name', 'blog[random_href]')
    itBehavesLike('input_with_', 'type', 'url')

  describe 'auto-detection', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('anchor_url'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'url')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_anchor_url_input')
    itBehavesLike('label_with_text', 'Anchor Url')
    itBehavesLike('input_with_', 'id', 'blog_anchor_url')
    itBehavesLike('input_with_', 'name', 'blog[anchor_url]')
    itBehavesLike('input_with_', 'type', 'url')