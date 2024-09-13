# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Module for generation form
module HexletCode
  class Error < StandardError; end
  # Your code goes here...

  # Class for getting html tag
  class Tag
    SINGLE_TAGS = %w"[br img input]".freeze

    def builde_single_tag(tag, attributes_formatted)
      "<#{tag} #{attributes_formatted}/>"
    end

    def build_double_tag(tag, attributes_formatted, content)
      "<#{tag} #{attributes_formatted}>#{content || ''}</#{tag}>"
    end

    def build(tag, *attributes)
      attributes_formatted = attributes[0]&.map { |key, value| "#{key}=\"#{value}\"" }&.join(' ') || ''
      content = block_given? && yield

      if SINGLE_TAGS.include?(tag)
        builde_single_tag(tag, attributes_formatted)
      else
        build_double_tag(tag, attributes_formatted, content)
      end
    end
  end

  def self.form_for(_, options = {})
    url = options[:url] || '#'

    "<form action=\"#{url}\" method=\"post\"></form>"
  end
end
