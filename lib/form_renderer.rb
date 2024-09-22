# frozen_string_literal: true

class FormRenderer
  autoload :Tag, 'tag.rb'

  def html(fields, options)
    form_options = {
      action: options[:url] || '#',
      method: options[:method] || 'post'
    }.merge(options)
    form_options.delete(:url)

    html_tags = fields.map do |field|
      field => {tag_type:, **rest}
      content = rest.delete :content
      Tag.build(tag_type, rest) { content }
    end

    Tag.build('form', form_options) { html_tags.join }
  end
end
