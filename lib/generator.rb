require 'rubygems'
require 'json'

class Generator
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

	def generate_resume(resume_data, location, formatter)
		resume = generate_output(resume_data, formatter)
		file = File.new(location, "w")
		file.puts(resume)
	end

end
