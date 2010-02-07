require 'rubygems'
require 'json'

class Generator
	attr_accessor :json_resume
   
	def initialize	
		@json_resume = "data/resume.js"
	end

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

	def get_jsonified_resume
		resume = ""
		File.open(@json_resume).each_line { |line| resume += line }
		return JSON.parse(resume)
	end

	def generate_readme
		resume = get_jsonified_resume
		formatter = PlainTextFormatter.new
		resume_txt = generate_output(resume, formatter)
		txt_file = File.new("README", "w")
		txt_file.puts(resume_txt)
		print resume_txt
	end

	def generate_txt
		resume = get_jsonified_resume
		formatter = PlainTextFormatter.new
		resume_txt = generate_output(resume, formatter)
		txt_file = File.new("resume.txt", "w")
		txt_file.puts(resume_txt)
	end

	def generate_html
		resume = get_jsonified_resume
		formatter = HtmlFormatter.new
		resume_html = generate_output(resume, formatter)
		html_file = File.new("resume.html", 'w')
		html_file.puts(resume_html)
	end
end
