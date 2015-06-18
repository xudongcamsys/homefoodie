module ApplicationHelper
  def print_error_messages(obj)
    html = '<strong>Please correct the problems below:</strong></br>'
    line_break = '</br>'.html_safe
    obj.object.nil? ? '' : html << obj.object.errors.full_messages.uniq.join(". #{line_break}")
    return html.html_safe
  end

  def form_group_tag(errors, &block)
    if errors.any?
      content_tag :div, capture(&block), class: 'form-group has-error'
    else
      content_tag :div, capture(&block), class: 'form-group'
    end
  end

  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    (redcarpet.render text).html_safe
  end

  def geocodable?(user)
    user && user.location.is_geocodable?
  end

  def gmap_with_coords_url coords
    "https://maps.google.com/maps?z=12&t=m&q=loc:#{coords[0]}+#{coords[1]}"
  end
end
