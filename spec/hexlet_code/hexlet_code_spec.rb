# frozen_string_literal: true

require 'hexlet_code'
require 'spec_helper'

RSpec.describe HexletCode do
  let(:user) { User.new name: 'Rob', job: 'hexlet', gender: 'm' }

  it 'Generate form with non-existen field' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))

    expect do
      described_class.form_for user do |f|
        f.input :name
        f.input :age
      end
    end.to raise_error(NoMethodError)
  end

  it 'Generate full form with submit' do
    stub_const('User', Struct.new(:name, :job, :gender, keyword_init: true))
    custom_user = User.new job: 'hexlet'

    form = described_class.form_for custom_user, url: '#' do |f|
      f.input :name
      f.input :job
      f.submit 'Wow'
    end

    expect(form).to eq fixture('form.html').read
  end
end
