require 'lib/formatter'
require 'lib/generator'

JSON_RESUME = "data/resume.js"

task :default => [:all]

task :all => [:txt, :readme, :html]

task :txt do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "txt/resume.txt", PlainTextFormatter.new)
end

task :readme do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "README", PlainTextFormatter.new)
end

task :html do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "html/resume.html", HtmlFormatter.new)
end

def get_jsonified_resume
  resume = ""
  File.open(JSON_RESUME).each_line { |line| resume += line }
  return JSON.parse(resume)
end
