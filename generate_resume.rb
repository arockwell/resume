#!/bin/ruby

require 'rubygems'
require 'json'

def generate_output(resume, formatter)
	result = formatter.start_document
	personal_info = resume['personal_info']
	result += formatter.para(personal_info['name'])
	result += formatter.para(personal_info['email']) 
	result += formatter.para(personal_info['phone'])
	result += formatter.break_line

	experience = resume['experience']
	result += formatter.heading("EXPERIENCE")
	experience.each { |exp| result += formatter.para(exp) }
	result += formatter.break_line 

	result += formatter.heading("WORK HISTORY")
	work_history = resume['work_history']
	work_history.each do |job|
		result += formatter.para(job["basic_info"])
		result += formatter.para(job["description"])
		result += formatter.break_line
	end

	result += formatter.heading("SKILLS")
	skills = resume['skills']
	skills.each do |skill|
		if skill.has_key?('some')
			result += formatter.para(skill['skill'])
			sig = "Significant experience with " + skill['significant'] + "."
			some = "Some experience with " + skill['some'] + "."
			result += formatter.list([sig, some])
		else
			sig = skill['skill'] + ": "
			sig += "Significant experience with " + skill['significant']  + "."
			result += formatter.para(sig)
		end
	end
	result += formatter.break_line

	education = resume['education']
	result += formatter.heading("EDUCATION")
	result += formatter.para(education['location'])
	result += formatter.para(education['degree'])
	result += formatter.break_line


	references = resume['references']
	result += formatter.heading("REFERENCES")
	references.each { |ref| result += formatter.para(ref) }

	result += formatter.end_document
	return result
end

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

json_resume = "resume.js"
resume = ""
File.open(json_resume).each_line { |line| resume += line }
resume = JSON.parse(resume)

formatter = PlainTextFormatter.new
resume_txt = generate_output(resume, formatter)
txt_file = File.new("README", "w")
txt_file.puts(resume_txt)
print resume_txt


formatter = HtmlFormatter.new
resume_html = generate_output(resume, formatter)
html_file = File.new("resume.html", 'w')
html_file.puts(resume_html)
