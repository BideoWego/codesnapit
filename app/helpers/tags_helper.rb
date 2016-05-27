module TagsHelper
  def tags_to_links(text, tags)
    parsed = []
    parsed = text.split(' ')
    tags.each do |tag|
      words = text.split(' ')
      words.each_with_index do |word, index|
        if word.chars.first == '#'
          word = word[1..-1]
          if word =~ /#{tag.name}/
            link = link_to("##{tag.name}", "/search?q=#{tag.name}")
            word.gsub!(tag.name, link)
            parsed[index] = word;
          end
        end
      end
    end
    result = parsed.join(' ')
    result.html_safe
  end
end
