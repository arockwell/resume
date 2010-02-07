require 'rubygems'
require 'json'

class Generator
  def generate_output(resume, formatter)
    formatter.start_document
    personal_info = resume['personal_info']
    formatter.para(personal_info['name'])
    formatter.para(personal_info['email']) 
    formatter.para(personal_info['phone'])
    formatter.break_line

    experience = resume['experience']
    formatter.heading("EXPERIENCE")
    experience.each { |exp| formatter.para(exp) }
    formatter.break_line 

    formatter.heading("WORK HISTORY")
    work_history = resume['work_history']
    work_history.each do |job|
      formatter.para(job["basic_info"])
      formatter.para(job["description"])
      formatter.break_line
    end

    formatter.heading("SKILLS")
    skills = resume['skills']
    skills.each do |skill|
      if skill.has_key?('some')
        formatter.para(skill['skill'])
        sig = "Significant experience with " + skill['significant'] + "."
        some = "Some experience with " + skill['some'] + "."
        formatter.list([sig, some])
      else
        sig = skill['skill'] + ": "
        sig += "Significant experience with " + skill['significant']  + "."
        formatter.para(sig)
      end
    end
    formatter.break_line

    education = resume['education']
    formatter.heading("EDUCATION")
    formatter.para(education['location'])
    formatter.para(education['degree'])
    formatter.break_line


    references = resume['references']
    formatter.heading("REFERENCES")
    references.each { |ref| formatter.para(ref) }

    formatter.end_document
    return formatter.render
  end

  def generate_resume(resume_data, location, formatter)
    resume = generate_output(resume_data, formatter)
    file = File.new(location, "w")
    file.puts(resume)
  end
end
