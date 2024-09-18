# frozen_string_literal: true

require 'tag'

RSpec.describe Tag do
  it 'Generate double tag with attrs and without content' do
    div_tag = Tag.build('label', for: 'email')
    expect(div_tag).to eq '<label for="email"/>'
  end

  it 'Generate double tag with attrs and content' do
    div_tag = Tag.build('label', for: 'email') { 'Email' }
    expect(div_tag).to eq '<label for="email">Email</label>'
  end

  it 'Generate double tag without attrs and content' do
    div_tag = Tag.build('div')
    expect(div_tag).to eq '<div />'
  end

  it 'Generate single tag with attrs and without content' do
    div_tag = Tag.build('input', value: 'email', name: 'vasya')
    expect(div_tag).to eq '<input value="email" name="vasya"/>'
  end

  it 'Generate single tag without attrs and content' do
    div_tag = Tag.build('input')
    expect(div_tag).to eq '<input />'
  end
end
