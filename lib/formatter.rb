class PlainTextFormatter
  def heading(string)
    return string.upcase + "\n"
  end

  def para(string)
    return string + "\n"
  end

  def list(strings) 
    result = ""
    strings.each do |string|
      result += "  - " + string + "\n"
    end
    return result
  end

  def break_line()
    return "\n"
  end

  def start_document
    return ""
  end

  def end_document
    return ""
  end
end

class HtmlFormatter
  def heading(string)
    return "<h1>" + string.upcase + "</h1>\n"
  end

  def para(string)
    return "<p>" + string + "</p>\n"
  end

  def list(strings)
    result = "<ul>\n"
    strings.each do |string|
      result += "<li>" + string + "</li>\n"
    end
    result += "</ul>\n"
    return result
  end

  def break_line()
    return "<br />\n"
  end

  def start_document
    return "<html>\n" +
      "<head>\n" +
      "<link rel=\"stylesheet\" href=\"resume.css\" />\n" +
      "</head>\n" +
      "<body>\n"
  end

  def end_document
    return "</body>\n" +
      "</html>"
  end

end
