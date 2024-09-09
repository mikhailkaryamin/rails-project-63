# frozen_string_literal: true

require 'hexlet_code'

RSpec.describe HexletCode::Tag do
  it 'Generate double tag with attrs and without content' do
    tag = HexletCode::Tag.new
    div_tag = tag.build('label', for: 'email')
    expect(div_tag).to eq '<label for="email"></label>'
  end

  it 'Generate double tag with attrs and content' do
    tag = HexletCode::Tag.new
    div_tag = tag.build('label', for: 'email') { 'Email' }
    expect(div_tag).to eq '<label for="email">Email</label>'
  end

  it 'Generate double tag without attrs and content' do
    tag = HexletCode::Tag.new
    div_tag = tag.build('div')
    expect(div_tag).to eq '<div ></div>'
  end

  it 'Generate single tag with attrs and without content' do
    tag = HexletCode::Tag.new
    div_tag = tag.build('input', value: 'email')
    expect(div_tag).to eq '<input value="email"></input>'
  end

  it 'Generate single tag without attrs and content' do
    tag = HexletCode::Tag.new
    div_tag = tag.build('input')
    expect(div_tag).to eq '<input ></input>'
  end
end
