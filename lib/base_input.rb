# frozen_string_literal: true

module HexletCode
  module Inputs
    class BaseInput
      attr_reader :input, :label

      def initialize(field_name)
        @label = generate_label(field_name)
      end

      private

      def generate_label(field_name)
        {
          tag_type: 'label',
          for: field_name,
          content: field_name.capitalize
        }
      end
    end
  end
end
