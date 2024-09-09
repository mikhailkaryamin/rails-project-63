# frozen_string_literal: true

require_relative "hexlet_code/version"

module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  class Tag
    SINGLE_TAGS = ['br', 'img', 'input'].freeze

    def build(tag, *attributes)
      attributes_formatted = attributes[0]&.map { |key, value| "#{key.to_s}=\"#{value}\"" }&.join(' ') || ''
      content = (block_given? && yield) || ''

      if SINGLE_TAGS.include?(tag)
        "<#{tag} #{attributes_formatted}/>"
      else
        "<#{tag} #{attributes_formatted}>#{content}</#{tag}>"
      end
    end
  end
end
