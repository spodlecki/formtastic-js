describe '#select', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('user_type', {label: "Type", collection: [['Admin','admin'],['Editor','editor']]}))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'select')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_user_type_input')
    itBehavesLike('label_with_text', 'Type')
    itBehavesLike('input_with_', 'id', 'blog_user_type', 'select')
    itBehavesLike('input_with_', 'name', 'blog[user_type]', 'select')