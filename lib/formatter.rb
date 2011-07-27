# encoding: utf-8
require 'rubygems'
require 'prawn'

class PlainTextFormatter
  attr :result

  def initialize
    @result = ""
  end

  def heading(string)
    @result += string + "\n\n"
  end

  def center_header(text)
    @result += "#{text}\n"
  end

  def personal_info(email, phone, website)
    @result += "#{email}\n#{phone}\n#{website}\n\n"
  end

  def overview(text)
    @result += "#{text}\n\n"
  end

  def skills(skills)
    skills.each do |skill|
      @result += "#{skill[0]}: #{skill[1]}\n"
    end
    @result += "\n"
  end

  def work_history(work_history)
    work_history.each do |job|
      @result += "#{job['title']}\n"
      @result += "#{job['location']}, #{job['dates']}\n"
      job['accomplishments'].each do |accomplishment|
        @result += "  * #{accomplishment}\n"
      end
      @result += "\n"
    end
  end

  def education(location, degree)
    @result += "#{location}\n"
    @result += "#{degree}\n"
  end

  def para(string)
    @result += string + "\n"
  end

  def list(strings) 
    result = ""
    strings.each do |string|
      result += "  * " + string + "\n"
    end
    @result += result
  end

  def break_line()
    @result += "\n"
  end

  def render(filename)
    File.open(filename, 'w') {|f| f.write(@result) }
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
    @pdf.text "#{string}\n", :style => :bold
    @pdf.stroke_horizontal_rule
    @pdf.text "\n"
  end

  def personal_info(email, phone, website)
    @pdf.text "#{email} • #{phone} • #{website}\n\n", :align => :center
  end

  def overview(string)
    @pdf.text string + "\n\n"
  end

  # Draw a table with borders around the outside and between the two columns.
  def skills(skills)
    @pdf.table skills do
      cells.borders = []
      cells.padding = 2
      rows(0..skills.size).columns(0).borders = [:top, :left, :right]
      rows(0).columns(1..2).borders = [:top, :right]
      rows(1..skills.size-2).columns(0).borders = [:left, :right]
      rows(1..skills.size-2).columns(1..2).borders = [:right]
      rows(skills.size-1).columns(1..2).borders = [:right, :bottom]
      rows(skills.size-1).columns(0).borders = [:left, :right, :bottom]
    end
    @pdf.text "\n"
  end

  def work_history(jobs)
    jobs.each do |job|
      @pdf.text job['title'], :style => :bold
      @pdf.text("#{job['location']}, #{job['dates']}")
      list(job['accomplishments'])
      @pdf.text "\n"
    end

  end

  def education(location, degree)
    @pdf.text "#{location}\n"
    @pdf.text "#{degree}\n"
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
