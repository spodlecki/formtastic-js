describe '#number', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'number'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'number')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_allow_comments_input')
    itBehavesLike('label_with_text', 'Allow Comments')
    itBehavesLike('input_with_', 'id', 'blog_allow_comments')
    itBehavesLike('input_with_', 'name', 'blog[allow_comments]')
    itBehavesLike('input_with_', 'type', 'number')

  describe 'with min/max/step set', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('allow_comments', as: 'number', input_html: {step: 10, min: 5, max: 110}))
      @el = $('<div>'+@form.render()+'</div>')

    itBehavesLike('input_with_', 'min', '5')
    itBehavesLike('input_with_', 'max', '110')
    itBehavesLike('input_with_', 'step', '10')
