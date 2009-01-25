# Uninstall hook code here
puts "Removing files..."
dir = "/javascripts/swf/"
["swfupload.js", "swfupload.swf", "swfupload.cookies.js","fileprogress.js","handlers.js"].each do |js_file|
	File.delete(RAILS_ROOT+"/public"+dir+ js_file)
end
puts "Files removed - Desinstallation complete!"
