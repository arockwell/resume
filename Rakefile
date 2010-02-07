require 'lib/formatter'
require 'lib/generator'

task :default => [:all]

task :all => [:txt, :readme, :html]

task :txt do
	generator = Generator.new
	generator.generate_txt
end

task :readme do
	generator = Generator.new
	generator.generate_readme()
end

task :html do
	generator = Generator.new
	generator.generate_html()
end
