# frozen_string_literal: true

require_relative 'base_input'

module HexletCode
  module Inputs
    class StringInput < BaseInput
      def initialize(field_name, value, *options)
        super()

        @data = {
          name: field_name,
          type: 'text',
          tag_type: 'input',
          value:
        }.merge(options[0] || {})
      end
    end
  end
end
