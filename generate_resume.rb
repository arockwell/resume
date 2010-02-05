#!/bin/ruby

require 'rubygems'
require 'json'

def generate_plain_text(resume)
	result = ""
	personal_info = resume['personal_info']
	result = personal_info['name'] + "\n"
	result += personal_info['email'] + "\n"
	result += personal_info['phone'] + "\n"
	result += "\n"

	experience = resume['experience']
	result += "EXPERIENCE\n"
	experience.each { |exp| result += exp + "\n" }
	result += "\n"

	result += "WORK HISTORY\n"
	work_history = resume['work_history']
	work_history.each do |job|
		result += job["basic_info"] + "\n"
		result += job["description"] + "\n"
		result += "\n"
	end

	result += "SKILLS\n"
	skills = resume['skills']
	skills.each do |skill|
		if skill.has_key?('some')
			result += skill['skill'] + "\n"
			result += "  - Significant experience with " + skill['significant'] + ".\n"
			result += "  - Some experience with " + skill['some'] + ".\n"
		else
			result += skill['skill'] + ": "
			result += "Significant experience with " + skill['significant'] + ".\n"
		end
	end
	result += "\n"

	education = resume['education']
	result += "EDUCATION\n"
	result += education['location'] + "\n"
	result += education['degree'] + "\n"
	result += "\n"


	references = resume['references']
	result += "REFERENCES\n"
	references.each { |ref| result += ref + "\n" }

	return result
end

json_resume = "resume.js"
resume = ""
File.open(json_resume).each_line { |line| resume += line }
resume = JSON.parse(resume)

resume_txt = generate_plain_text(resume)
print resume_txt
