# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Module for generation form
module HexletCode
  class Error < StandardError; end

  # Class for getting html tag
  class Tag
    DOUBLE_TAGS = %w[textarea].freeze

    def builde_single_tag(tag, attributes_formatted)
      "<#{tag} #{attributes_formatted || ' '}/>"
    end

    def build_double_tag(tag, attributes_formatted, content)
      "<#{tag} #{attributes_formatted}>#{content || ''}</#{tag}>"
    end

    def build_tag(tag, attributes_formatted, content)
      if DOUBLE_TAGS.include?(tag) || content
        build_double_tag(tag, attributes_formatted, content)
      else
        builde_single_tag(tag, attributes_formatted)
      end
    end

    def build(tag, *attributes)
      attributes_formatted = attributes[0]&.map { |key, value| "#{key}=\"#{value}\"" }&.join(' ') || ''
      content = block_given? && yield

      build_tag(tag, attributes_formatted, content)
    end
  end

  # Class for getting form with fields
  class Form
    attr_accessor :data, :options, :fields, :tag

    def initialize(data, options)
      @data = data
      @options = options
      @tag = HexletCode::Tag.new
      @fields = []
    end

    def field?(field_name)
      data.public_send field_name
    end

    def label(field_name)
      tag.build('label', for: field_name) { field_name.capitalize }
    end

    def custom_field(field_name, *options)
      field_data = options[0]
      field_data => {as:, **rest}
      case as
      when :text
        text_options = {
          rows: 40,
          cols: 20,
          name: field_name,
          type: 'text'
        }
        pp text_options.merge(rest)
        tag.build('textarea', text_options.merge(rest)) { data[field_name] }
      else
        default_field(field_name, *options)
      end
    end

    def default_field(field_name, *options)
      input_options = {
        name: field_name,
        type: 'text',
        value: data[field_name]
      }

      tag.build('input', input_options.merge(options[0] || {}))
    end

    def input(field_name, *options)
      field?(field_name)

      is_custom_field = !options.empty? && options[0][:as]

      field = if !is_custom_field
                default_field(field_name, *options)
              else
                custom_field(field_name, *options)
              end

      fields << label(field_name)
      fields << field
    end

    def submit(value = 'Save')
      submit = tag.build('input', type: 'submit', value:)
      fields << submit
    end

    def html
      url = options[:url] || '#'
      tag.build('form', action: url, method: 'post') { fields.join }
    end
  end

  def self.form_for(data, options = {})
    form = HexletCode::Form.new data, options

    yield(form) if block_given?
    form.html
  end
end
