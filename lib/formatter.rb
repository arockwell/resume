require 'prawn'

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

  def render(filename) 
    File.open(filename, "w") { |f| f.write(@result) }
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

  def render(filename)
    @result = "<html>\n" +
      "<head>\n" +
      "<link rel=\"stylesheet\" href=\"resume.css\" />\n" +
      "</head>\n" +
      "<body>\n" +
      @result +
      "</body>\n" +
      "</html>"
    File.open(filename, "w") { |f| f.write(@result) }
  end
end

class PdfFormatter
  attr :pdf
  attr :result

  def initialize
    @result = ""
    @pdf = Prawn::Document.new
    @pdf.font "Times-Roman"
  end

  def heading(string)
    @pdf.text "#{string.upcase}\n", :style => :bold
  end

  def para(string)
    @pdf.text "#{string}\n"
  end

  def list(strings)
    strings.each do |string|
      @pdf.text "- #{string}\n", :indent_paragraphs => 12
    end
  end

  def break_line()
    @pdf.text "\n"
  end

  def render(filename)
    return @pdf.render_file(filename)
  end
end
