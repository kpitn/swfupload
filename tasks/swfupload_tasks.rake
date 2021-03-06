namespace :swfupload do
	namespace :update do
		desc "Copies javascripts to public/javascripts/swf"
		task :javascripts do
			puts "Copying files..."
			project_dir = RAILS_ROOT + '/public/javascripts/swf'
      makedirs(project_dir)
			scripts = Dir[File.join(File.dirname(__FILE__), '..') + '/javascripts/swf/*.*']
      FileUtils.cp(scripts, project_dir)
			puts "files copied successfully."
		end
	end

	namespace :install do
		desc "Installs the jQuery and jRails javascripts to public/javascripts"
		task :javascripts do
			Rake::Task['swfupload:update:javascripts'].invoke
		end
	end
end
