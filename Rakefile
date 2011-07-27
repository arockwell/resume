require 'lib/formatter'
require 'lib/generator'
require 'yaml'

RESUME = "data/resume.yml"

task :default => [:all]

desc "Generate resume in all formats"
task :all => [:readme, :pdf]

desc "Generate readme for display on github"
task :readme do
  resume_data = load_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "README", PlainTextFormatter.new)
end

desc "Generate resume in pdf format"
task :pdf do
  resume_data = load_resume
  generator = Generator.new
  generator.generate_resume(resume_data, "alex_rockwell.pdf", PdfFormatter.new)
end

def load_resume
  YAML::load_file(RESUME)
end
