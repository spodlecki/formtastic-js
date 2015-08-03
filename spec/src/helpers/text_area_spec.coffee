describe '#text_area', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.text_area('random_name'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('form_helper', 'textarea')
    itBehavesLike('form_helper_with_', 'id', 'blog_random_name', 'textarea')
    itBehavesLike('form_helper_with_', 'name', 'blog[random_name]', 'textarea')