require_relative 'lib/formatter'
require_relative 'lib/generator'

JSON_RESUME = "data/resume.js"

task :default => [:all]

desc "Generate resume in all formats"
task :all => [:txt, :readme, :html, :pdf]

desc "Generate resume in plain text"
task :txt do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "txt/resume.txt", PlainTextFormatter.new)
end

desc "Generate readme for display on github"
task :readme do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "README", PlainTextFormatter.new)
end

desc "Generate resume in html format"
task :html do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "html/resume.html", HtmlFormatter.new)
end

desc "Generate resume in pdf format"
task :pdf do
  resume_data = get_jsonified_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "pdf/resume.pdf", PdfFormatter.new)
end

def get_jsonified_resume
  resume = ""
  File.open(JSON_RESUME).each_line { |line| resume += line }
  return JSON.parse(resume)
end
