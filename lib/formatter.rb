# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'prawn'
require 'prawn/table'

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
      @result += "#{job['title']} - #{job['location']}, #{job['dates']}\n"
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
      rows(0..skills.size).columns(0).padding_right = 60
    end
    @pdf.text "\n"
  end

  def work_history(jobs)
    jobs.each do |job|
      @pdf.text "#{job['title']} - #{job['location']}, #{job['dates']}" , :style => :bold
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
    list_data = strings.map { |string| ["•", string] }
    pdf.table(list_data, cell_style: { borders: [], padding: [0, 10, 0, 0] },
              column_widths: {0 => 20, 1 => pdf.bounds.width - 20 }) do
      column(0).style(padding: [0,0,0,10])
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
