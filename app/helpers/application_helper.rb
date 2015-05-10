module ApplicationHelper
  def print_error_messages(obj)
    html = '<strong>Please correct the problems below:</strong></br>'
    line_break = '</br>'.html_safe
    obj.object.nil? ? '' : html << obj.object.errors.full_messages.uniq.join(". #{line_break}")
    return html.html_safe
  end
end
