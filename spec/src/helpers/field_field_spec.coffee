describe '#file_field', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.file_field('random_name'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('form_helper', 'input[type="file"]')
    itBehavesLike('form_helper_with_', 'id', 'blog_random_name')
    itBehavesLike('form_helper_with_', 'name', 'blog[random_name]')
    itBehavesLike('form_helper_with_', 'type', 'file')