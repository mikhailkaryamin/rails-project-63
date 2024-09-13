require 'hexlet_code'

RSpec.describe HexletCode do
  let(:user) { User.new name: 'Rob' }

  it 'Generate form WITHOUT url' do
    stub_const('User', Struct.new(:name, :job, keyword_init: true))

    form = described_class.form_for user do |f|
    end

    expect(form).to eq '<form action="#" method="post"></form>'
  end

  it 'Generate form WITH url' do
    stub_const('User', Struct.new(:name, :job, keyword_init: true))

    form = described_class.form_for user, url: '/users' do |f|
    end

    expect(form).to eq '<form action="/users" method="post"></form>'
  end
end
