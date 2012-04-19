require 'warbler'
require 'fpm'

Warbler::Task.new
app_name="aws-twitter-feed"

desc "Build and then start the app on localhost"
task :run do |t|  
  FileTest.exist?("#{app_name}.jar") ? sh("java -jar aws-twitter-feed.jar") : puts("No jar file found. Run rake build first.")
end 

desc "Build the app as an executable jar"
task :build => ['jar:clean','jar'] 

desc "Package the app as a exectable jar within an RPM"
task :package => :build do  
  sh "mkdir -p build-output/opt/"
  sh "cp #{app_name}.jar} build-output/opt/"
  fpm_options = [
    "--post-install packaged-scripts/post-install.sh",
    "--pre-uninstall packaged-scripts/pre-uninstall.sh",
    "--description 'Simple demo application that scans a twitter feed for a particular hashtag. Built for AWS summit.'",
    "-v 0.0.1",
    "-s dir -t rpm -a noarch",
    "-C build-output opt",
  ].join(" ")    
  sh "bundle exec fpm #{fpm_opts}"
  sh "rm -rf build-output"
end

