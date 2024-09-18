# frozen_string_literal: true

module Tag
  DOUBLE_TAGS = %w[textarea].freeze

  def self.builde_single_tag(tag, attributes_formatted)
    "<#{tag} #{attributes_formatted || ' '}/>"
  end

  def self.build_double_tag(tag, attributes_formatted, content)
    "<#{tag} #{attributes_formatted}>#{content || ''}</#{tag}>"
  end

  def self.build_tag(tag, attributes_formatted, content)
    if DOUBLE_TAGS.include?(tag) || content
      build_double_tag(tag, attributes_formatted, content)
    else
      builde_single_tag(tag, attributes_formatted)
    end
  end

  def self.build(tag, *attributes)
    attributes_formatted = attributes[0]&.map { |key, value| "#{key}=\"#{value}\"" }&.join(' ') || ''
    content = block_given? && yield

    build_tag(tag, attributes_formatted, content)
  end
end
