module NestablesHelper

  def nested_ol(objects, options = {}, &block)
    objects = objects.order(:lft) if objects.is_a? Class

    return '' if objects.size == 0

    if options[:id].present?
      output = "<ol id=\"#{options.fetch(:id)}\">"
    else
      output = '<ol>'
    end
    path = [nil]

    objects.each_with_index do |o, i|
      if o.parent_id != path.last
        # We are on a new level, did we descend or ascend?
        if path.include?(o.parent_id)
          # Remove the wrong trailing path elements
          while path.last != o.parent_id
            path.pop
            output << '</li></ol>'
          end
          output << '</li>'
        else
          path << o.parent_id
          output << '<ol>'
        end
      elsif i != 0
        output << '</li>'
      end
      output << "<li data-id=\"#{o.id}\" id=\"#{o.class.to_s.underscore}_li_#{o.id}\" >" + capture(o, path.size - 1, &block)
    end

    output << '</li></ol>' * path.length
    output.html_safe
  end

  def sorted_nested_ol(objects, order, &block)
    nested_ol sort_list(objects, order), &block
  end

  private

  def sort_list(objects, order)
    objects = objects.order(:lft) if objects.is_a? Class

    # Partition the results
    children_of = {}
    objects.each do |o|
      children_of[o.parent_id] ||= []
      children_of[o.parent_id] << o
    end

    # Sort each sub-list individually
    children_of.each_value do |children|
      children.sort_by!(&:order)
    end

    # Re-join them into a single list
    results = []
    recombine_lists(results, children_of, nil)

    results
  end

  def recombine_lists(results, children_of, parent_id)
    return false unless children_of[parent_id]
    children_of[parent_id].each do |o|
      results << o
      recombine_lists(results, children_of, o.id)
    end
  end

end
