require 'geokit'

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

  # miles between a specific dish and given lat/lng location
  def dish_distance(dish, lat, lon)
    dish_loc = dish.user.location rescue nil
    if dish_loc && dish_loc.is_visible
      Geokit::LatLng.new(lat, lon).distance_to(Geokit::LatLng.new(dish_loc.lat, dish_loc.lng))
    end
  end
end
