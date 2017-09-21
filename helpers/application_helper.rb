module ApplicationHelper

  # nav_links
  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "my blog"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

end
