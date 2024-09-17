require 'hexlet_code'
require 'spec_helper'

RSpec.describe HexletCode do
  let(:user) { User.new name: 'Rob', job: 'hexlet', gender: 'm' }

  it 'Generate form WITHOUT url' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))

    form = described_class.form_for user do |f|
    end

    expect(form).to eq '<form action="#" method="post"></form>'
  end

  it 'Generate form WITH url' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))

    form = described_class.form_for user, url: '/users' do |f|
    end

    expect(form).to eq '<form action="/users" method="post"></form>'
  end

  it 'Generate form with non-existen field' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))

    expect do
      described_class.form_for user do |f|
        f.input :name
        f.input :age
      end
    end.to raise_error(NoMethodError)
  end

  it 'Generate form with textarea and additional attrs' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))

    form = described_class.form_for user do |f|
      f.input :name, class: 'user-input'
      f.input :job, as: :text, rows: 50, cols: 50
    end

    expect(form).to eq fixture('form/textarea_additional_attrs.html').read
  end

  it 'Generate form with input and additional attrs' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))

    form = described_class.form_for user, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
    end

    expect(form).to eq fixture('form/input_additional_attrs.html').read
  end

  it 'Generate full form with submit' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))
    custom_user = User.new job: 'hexlet'

    form = described_class.form_for custom_user, url: '#' do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end

    expect(form).to eq fixture('form/with_submit.html').read
  end
end
