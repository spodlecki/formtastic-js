describe '#hidden', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('avatar', as: 'hidden'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'hidden')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_avatar_input')
    itBehavesLike('input_with_', 'id', 'blog_avatar')
    itBehavesLike('input_with_', 'name', 'blog[avatar]')
    itBehavesLike('input_with_', 'type', 'hidden')

    it 'does not have a label', ->
      expect(@el.find('label').length).toEqual 0

    it 'hides the wrapper', ->
      expect(@el.find('form > li').attr('style')).toEqual 'display: none;'