module ApplicationHelper

  def post_link(post)
    return post.link if post.link?
    return post_path(post) if post.text?
  end

  def flash_messages(flash)
    output = ''
    flash.each do |name, msg|
      output += content_tag :div, class: "alert #{name}" do
        if msg.is_a? Array
          flash_list msg
        else
          msg
        end
      end
    end
    output.html_safe
  end

  def flash_list(messages)
    content_tag :ul do
      list_items = ''
      messages.each do |message|
        list_items += content_tag(:li, message)
      end
      list_items.html_safe
    end
  end
end
