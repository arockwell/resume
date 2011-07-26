# encoding: utf-8
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

  def render
    return "<html>\n" +
      "<head>\n" +
      "<link rel=\"stylesheet\" href=\"resume.css\" />\n" +
      "</head>\n" +
      "<body>\n" +
      @result +
      "</body>\n" +
      "</html>"
  end
end

class PdfFormatter
  attr :pdf
  attr :result

  def initialize
    @result = ""
    @pdf = Prawn::Document.new
  end

  def heading(string)
    @pdf.text "#{string.upcase}\n", :style => :bold
  end

  def para(string)
    @pdf.text string + "\n"
  end

  def text(string)
    @pdf.text string
  end

  def bold_text(string)
    @pdf.text string, :style => :bold
  end

  def center(string)
    @pdf.text "#{string}\n", :align => :center
  end

  def center_header(string)
    @pdf.text "#{string.upcase}\n", :align => :center, :style => :bold, :size => 18
  end

  def list(strings)
    strings.each do |string|
      @pdf.indent(10) do
        @pdf.float { @pdf.text "•" }
        @pdf.indent(10) do
          @pdf.text "#{string}\n"
        end
      end
    end
  end
  
  def table(data)
    @pdf.table data do
      cells.borders = []
      cells.padding = 2
      rows(0..data.size).columns(0).borders = [:top, :left, :right]
      rows(0).columns(1..2).borders = [:top, :right]
      rows(1..data.size-2).columns(0..2).borders = [:left, :right]
      rows(data.size-1).columns(0..2).borders = [:left, :right, :bottom]
    end
  end

  def break_line()
    @pdf.text "\n"
  end

  def hr
    @pdf.stroke_horizontal_rule
  end

  def render(filename)
    return @pdf.render_file(filename)
  end
end
