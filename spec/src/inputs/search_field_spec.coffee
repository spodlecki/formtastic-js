describe '#search', ->
  describe 'generic', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}
      @form = new Formtastic(@object, @attrs, (f)-> f.input('finder', as: 'search'))
      @el = $('<div>'+@form.render()+'</div>')

    it 'has the form in @el', ->
      expect(@el.find('form').length).toEqual 1

    itBehavesLike('input_wrapper_with_class', 'search')
    itBehavesLike('input_wrapper_with_class', 'input')
    itBehavesLike('input_wrapper_with_id', 'blog_finder_input')
    itBehavesLike('label_with_text', 'Finder')
    itBehavesLike('input_with_', 'id', 'blog_finder')
    itBehavesLike('input_with_', 'name', 'blog[finder]')
    itBehavesLike('input_with_', 'type', 'search')

  describe 'auto-detection', ->
    beforeEach ->
      @object = Object.create({bam: 'bam'})
      @attrs = {label: 'World', as: 'blog', url: 'http://test.host'}


    describe '"search"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('search'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'search')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_search_input')
      itBehavesLike('label_with_text', 'Search')
      itBehavesLike('input_with_', 'id', 'blog_search')
      itBehavesLike('input_with_', 'name', 'blog[search]')
      itBehavesLike('input_with_', 'type', 'search')

    describe '"search_people"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('search_people'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'search')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_search_people_input')
      itBehavesLike('label_with_text', 'Search People')
      itBehavesLike('input_with_', 'id', 'blog_search_people')
      itBehavesLike('input_with_', 'name', 'blog[search_people]')
      itBehavesLike('input_with_', 'type', 'search')

    describe '"person_search"', ->
      beforeEach ->
        @form = new Formtastic(@object, @attrs, (f)-> f.input('person_search'))
        @el = $('<div>'+@form.render()+'</div>')

      it 'has the form in @el', ->
        expect(@el.find('form').length).toEqual 1

      itBehavesLike('input_wrapper_with_class', 'search')
      itBehavesLike('input_wrapper_with_class', 'input')
      itBehavesLike('input_wrapper_with_id', 'blog_person_search_input')
      itBehavesLike('label_with_text', 'Person Search')
      itBehavesLike('input_with_', 'id', 'blog_person_search')
      itBehavesLike('input_with_', 'name', 'blog[person_search]')
      itBehavesLike('input_with_', 'type', 'search')