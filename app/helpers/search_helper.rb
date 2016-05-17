module SearchHelper

  def preview_description(description, query)
    preview_chars = 120
    query = sanitize(query)

    if index = description.index(query)
      trim = query.length + preview_chars
      start = index - trim >= 0 ? index - trim : 0
      preview = description[start..(index + trim)]
      sanitize("#{preview.gsub(query, "<b>#{query}</b>")}...")
    else
      "#{description[0..preview_chars]}..."
    end
  end

end
