# frozen_string_literal: true

require_relative 'text_input'
require_relative 'string_input'

module HexletCode
  class Form
    attr_reader :data
    attr_accessor :fields

    def initialize(data)
      @data = data
      @fields = []
    end

    def field?(field_name)
      data.public_send field_name
    end

    def label(field_name)
      {
        tag_type: 'label',
        for: field_name,
        content: field_name.capitalize
      }
    end

    def submit(value = 'Save')
      submit = {
        tag_type: 'input',
        type: 'submit',
        value:
      }
      fields << submit
    end

    def input(field_name, *options)
      field?(field_name)

      is_text_input = !options.empty? && options[0][:as]

      field = if is_text_input
                get_text_input_data(field_name, *options)
              else
                get_string_input_data(field_name, *options)
              end

      fields << label(field_name)
      fields << field
    end

    private

    def get_text_input_data(field_name, *options)
      Inputs::TextInput.new(field_name, data[field_name], *options).data
    end

    def get_string_input_data(field_name, *options)
      Inputs::StringInput.new(field_name, data[field_name], *options).data
    end
  end
end
