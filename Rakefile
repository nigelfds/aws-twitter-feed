require 'warbler'
require 'fpm'

Warbler::Task.new
app_name="aws-twitter-feed"

desc "Build and then start the app on localhost"
task :run do |t|  
  FileTest.exist?("#{app_name}.war") ? sh("java -jar aws-twitter-feed.war") : puts("No war file found. Run rake build first.")
end 

desc "Build the app as an executable jar"
task :build => ['war:clean','war']

desc "Clean out the build artifacts"
task :clean do
  sh "rm -rf build-output"
end

desc "Package the app as a exectable jar within an RPM"
task :package => [:clean, :build] do  
  sh "mkdir -p build-output/opt/"
  sh "cp #{app_name}.war build-output/opt/"
  fpm_options = [
    "-n #{app_name}",
    "--post-install packaged-scripts/post-install.sh",
    "--pre-uninstall packaged-scripts/pre-uninstall.sh",
    "--description 'Simple demo application that scans a twitter feed for a particular hashtag. Built for AWS summit.'",
    "-v 0.0.1",
    "-s dir -t rpm -a noarch",
    "-C build-output opt",
  ].join(" ")    
  sh "bundle exec fpm #{fpm_options}"
end

