# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'form'
require_relative 'form_renderer'

# Module for generation form
module HexletCode
  class Error < StandardError; end

  autoload(:Inputs, 'hexlet_code/inputs')

  def self.form_for(data, options = {})
    form = Form.new data

    yield(form) if block_given?

    fields = form.fields

    FormRenderer.new.html fields, options
  end
end
