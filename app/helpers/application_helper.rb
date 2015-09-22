module ApplicationHelper

  def title(page_title)
    content_for :title, page_title.to_s
  end

  def flash?
    flash[:notice] || flash[:alert]
  end

  def contact_title(contact)
    t('.contact') + " \"" + contact.full_name + "\""
  end

  def show_errors(instance, attribute)
    attribute = attribute.to_sym
    if instance.errors.has_key?(attribute)
      content_tag :ul, '', class: 'help-block' do
        instance.errors[attribute].map do |error|
          content_tag :li, error
        end.join('').html_safe
      end
    end
  end
end
