require 'fileutils'

task :default => [:run]

desc "Start the SniffDiff app"
task :run do
  ruby "sniffdiff.rb"
end

desc "Run unit tests"
task :test do
  puts "Running unit tests."
  sh %{ cd test; ruby test.rb }
end

desc "Clean up temp files"
task :clean do
  puts "Deleting temporary files."
  sh %{ rm tmp/* }
end
