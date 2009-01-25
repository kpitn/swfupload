# Install hook code here
puts "Copying files..."
dir = "javascripts/swf"
makedirs(RAILS_ROOT+"public"+dir)
["swfupload.js", "swfupload.swf", "swfupload.cookies.js","fileprogress.js","handler.js","swfupload.cookie.js"].each do |js_file|
	dest_file = File.join(RAILS_ROOT, "public", dir, js_file)
	src_file = File.join(File.dirname(__FILE__) , dir, js_file)
	FileUtils.cp_r(src_file, dest_file)
end
puts "Files copied - Installation complete!"
