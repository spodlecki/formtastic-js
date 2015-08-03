describe '#file', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('avatar', as: 'file'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'file')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_avatar_input')
    itBehavesLike('label_with_text', 'Avatar')
    itBehavesLike('input_with_', 'id', 'blog_avatar')
    itBehavesLike('input_with_', 'name', 'blog[avatar]')
    itBehavesLike('input_with_', 'type', 'file')