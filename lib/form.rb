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

      input_data = if is_text_input
                     get_text_input_data(field_name, *options)
                   else
                     get_string_input_data(field_name, *options)
                   end

      fields << input_data[:label]
      fields << input_data[:input]
    end

    private

    def get_text_input_data(field_name, *options)
      {
        label: Inputs::TextInput.new(field_name, data[field_name], *options).label,
        input: Inputs::TextInput.new(field_name, data[field_name], *options).input
      }
    end

    def get_string_input_data(field_name, *options)
      {
        label: Inputs::StringInput.new(field_name, data[field_name], *options).label,
        input: Inputs::StringInput.new(field_name, data[field_name], *options).input
      }
    end
  end
end
