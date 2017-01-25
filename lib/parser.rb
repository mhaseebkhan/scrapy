module Parser
  def parse(url_data)

    @html =  url_data
    @parse_page ||= Nokogiri::HTML(@html)

    %w(a h1 h2 h3).each do |element|
      @parse_page.css(element).each do |item|
        if element == "a"
          self.tags.create(tag: element, tagContent: item[:href])
        else
          self.tags.create(tag: element, tagContent: item.text)
        end
      end
    end
  end
end