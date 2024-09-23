# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    class TextInput < BaseInput
      def initialize(field_name, value, *options)
        super(field_name)

        field_data = options[0]
        field_data.delete :as

        @input = {
          name: field_name,
          type: 'text',
          tag_type: 'textarea',
          rows: 40,
          cols: 20,
          content: value
        }.merge(field_data)
      end
    end
  end
end
