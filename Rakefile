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
  sh "rm -rf build-output/opt"
  sh "rm aws-twitter-feed*.rpm"
end

desc "Package the app as a exectable jar within an RPM"
task :package => [:clean, :build] do

  sh "mkdir -p build-output"

  tanuki_wrapper_url = "http://wrapper.tanukisoftware.com/download/3.5.14/wrapper-linux-x86-32-3.5.14.tar.gz"
  wrapper_destination = "build-output/wrapper-linux-x86-32-3.5.14"
  sh "test -e #{wrapper_destination}.tar.gz || wget -O #{wrapper_destination}.tar.gz #{tanuki_wrapper_url}"
  sh "tar -xvzf #{wrapper_destination}.tar.gz -C build-output"

  dirs = {
    :bin => "build-output/opt/aws-twitter-feed/bin",
    :lib => "build-output/opt/aws-twitter-feed/lib",
    :conf => "build-output/opt/aws-twitter-feed/conf",
  }
  dirs.each do |key, path|
    sh "mkdir -p #{path}"
  end

  sh "cp #{app_name}.war #{dirs[:lib]}"
  sh "cp #{wrapper_destination}/bin/wrapper #{dirs[:bin]}/"
  sh "chmod u+x #{dirs[:bin]}/wrapper"

  sh "cp #{wrapper_destination}/src/bin/sh.script.in #{dirs[:bin]}/aws-twitter-feed"
  script = File.read "#{dirs[:bin]}/aws-twitter-feed"
  script.gsub!("@app.name@", "aws-twitter-feed")
  script.gsub!("@app.long.name@", "aws-twitter-feed")
  File.open("#{dirs[:bin]}/aws-twitter-feed", 'w') {|f| f.puts script}
  sh "chmod u+x #{dirs[:bin]}/aws-twitter-feed"

  sh "cp #{wrapper_destination}/lib/libwrapper.so #{dirs[:lib]}/"
  sh "cp #{wrapper_destination}/lib/wrapper.jar #{dirs[:lib]}/"
  sh "cp config/wrapper.conf #{dirs[:conf]}/"
  version = "0.1.#{ENV['GO_PIPELINE_COUNTER'] || 0}"
  fpm_options = [
    "-n #{app_name}",
    "--post-install packaged-scripts/post-install.sh",
    "--pre-uninstall packaged-scripts/pre-uninstall.sh",
    "--description 'Simple demo application that scans a twitter feed for a particular hashtag. Built for AWS summit.'",
    "-v #{version}",
    "-s dir -t rpm -a noarch",
    "-C build-output opt",
  ].join(" ")    
  sh "bundle exec fpm #{fpm_options}"
end

