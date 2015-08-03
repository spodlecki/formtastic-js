describe '#label', ->
  beforeEach ->
    @object = Object.create({bam: 'bam'})
    @attrs = {label: 'World', as: 'Blog', url: 'http://test.host'}
    @form = new Formtastic(@object, @attrs, -> 'HERE!')
    @form.constructor.required_string = '*'

  describe 'is null when', ->
    it 'no name given', ->
      expect(@form.label('')).toBeNull()

    it 'if undefined', ->
      expect(@form.label()).toBeNull()

  it 'returns a simple label with a name', ->
    expect(@form.label('Kustom')).toEqual '<label class="label">Kustom</label>'

  describe ':required', ->
    it 'returns a label with astrisk', ->
      expect(@form.label('Kustom', {required: true})).toEqual '<label class="label">Kustom*</label>'

    it 'returns a label with custom required text if set', ->
      @form.constructor.required_string = ' <strong data-toggle="tooltip" data-title="Required" class="required">*</strong>'
      expect(@form.label('Kustom', {required: true})).toEqual '<label class="label">Kustom <strong data-toggle="tooltip" data-title="Required" class="required">*</strong></label>'
  describe ':class', ->
    it 'overwrites the default css class', ->
      expect(@form.label('Kustom', {class: 'funkay chicken'})).toEqual '<label class="funkay chicken">Kustom</label>'