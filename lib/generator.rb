# encoding: utf-8
require 'rubygems'
require 'json'

class Generator
  def generate_resume(resume, filename, formatter)
    formatter.center_header(resume['name'])
    info_text = "#{resume['email']} • #{resume['phone']}"
    formatter.center(info_text)
    formatter.break_line

    formatter.heading(resume['heading'])
    formatter.para(resume['overview'])
    formatter.break_line

    formatter.heading("SKILLS")
    skills = resume['skills']
    skills.each do |skill|
      skill_line = "#{skill['name']}: #{skill['text']}"
      formatter.para(skill_line)
    end
    formatter.break_line

    formatter.heading("WORK HISTORY")
    work_history = resume['work_history']
    work_history.each do |job|
      formatter.para(job["basic_info"])
      formatter.para(job["description"])
      formatter.break_line
      accomplishments = job['accomplishments']
      accomplishments.each do |accomplishment|
        formatter.para(accomplishment)
      end
      formatter.break_line
    end


    education = resume['education']
    formatter.heading("EDUCATION")
    formatter.para(education['location'])
    formatter.para(education['degree'])
    formatter.break_line

    return formatter.render(filename)
  end

end
