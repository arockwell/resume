# encoding: utf-8
require 'rubygems'
require 'bundler/setup'
require 'json'
require 'erb'

class Generator
  def generate_resume(resume, filename, formatter)
    formatter.center_header(resume['name'])
    formatter.personal_info(resume['email'], resume['phone'], resume['website'])

    formatter.heading(resume['heading'])
    formatter.overview(resume['overview'])

    formatter.heading("Skills")
    skills = resume['skills']
    formatter.skills(skills)

    formatter.heading("Work History")
    work_history = resume['work_history']
    formatter.work_history(work_history)

    portfolio = resume['portfolio']
    formatter.heading("Portfolio")
    formatter.list(resume['portfolio'])
    formatter.break_line

    formatter.heading("Education")
    education = resume['education']
    formatter.education(education['location'], education['degree'])
    return formatter.render(filename)
  end

  def generate_cover_letter(template, position, company)
    template_file = File.read(template)
    template = ERB.new(template_file)

    @position = position
    @company = company

    return template.result(binding)
  end
end
