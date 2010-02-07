require 'pdf/writer'

class PlainTextFormatter
  attr :result

  def initialize
    @result = ""
  end

  def heading(string)
    @result += string.upcase + "\n"
  end

  def para(string)
    @result += string + "\n"
  end

  def list(strings) 
    result = ""
    strings.each do |string|
      result += "  - " + string + "\n"
    end
    @result += result
  end

  def break_line()
    @result += "\n"
  end

  def start_document
    @result += ""
  end

  def end_document
    @result += ""
  end

  def render 
    return @result
  end
end

class HtmlFormatter
  attr :result

  def initialize
    @result = ""
  end

  def heading(string)
    @result += "<h1>" + string.upcase + "</h1>\n"
  end

  def para(string)
    @result += "<p>" + string + "</p>\n"
  end

  def list(strings)
    result = "<ul>\n"
    strings.each do |string|
      result += "<li>" + string + "</li>\n"
    end
    result += "</ul>\n"
    @result += result
  end

  def break_line()
    @result += "<br />\n"
  end

  def start_document
    @result += "<html>\n" +
      "<head>\n" +
      "<link rel=\"stylesheet\" href=\"resume.css\" />\n" +
      "</head>\n" +
      "<body>\n"
  end

  def end_document
    @result += "</body>\n" +
      "</html>"
  end

  def render
    return @result
  end
end

class PdfFormatter
  attr :pdf

  def initialize
    @pdf = PDF::Writer.new
    @pdf.select_font "Times-Roman"
  end

  def heading(string)
    @pdf.text(string.upcase + "\n")
  end

  def para(string)
    @pdf.text(string + "\n")
  end

  def list(strings)
    strings.each do |string|
      @pdf.text(string + "\n")
    end
  end

  def break_line()
    @pdf.text("\n")
  end

  def start_document
  end

  def end_document
  end

  def render
    return @pdf.render
  end
end
