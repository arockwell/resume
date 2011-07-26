# encoding: utf-8
require 'rubygems'
require 'json'

class Generator
  def generate_resume(resume, filename, formatter)
    formatter.center_header(resume['name'])
    info_text = "#{resume['email']} • #{resume['phone']} • #{resume['website']}"
    formatter.center(info_text)
    formatter.break_line

    formatter.heading(resume['heading'])
    formatter.hr
    formatter.break_line
    formatter.para(resume['overview'])
    formatter.break_line

    formatter.heading("SKILLS")
    formatter.hr
    formatter.break_line
    skills = resume['skills']
    formatter.table(skills)
    formatter.break_line

    formatter.heading("WORK HISTORY")
    formatter.hr
    formatter.break_line
    work_history = resume['work_history']
    work_history.each do |job|
      formatter.bold_text(job['title'])
      formatter.text("#{job['location']}, #{job['dates']}")
      formatter.list(job['accomplishments'])
      formatter.break_line
    end

    portfolio = resume['portfolio']
    formatter.heading("PORTFOLIO")
    formatter.hr
    formatter.break_line
    formatter.list(resume['portfolio'])
    formatter.break_line

    education = resume['education']
    formatter.heading("EDUCATION")
    formatter.hr
    formatter.break_line
    formatter.para(education['location'])
    formatter.para(education['degree'])
    return formatter.render(filename)
  end

end
