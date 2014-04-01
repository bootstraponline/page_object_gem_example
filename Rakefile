# encoding: utf-8
require 'rubygems'
require 'rake'

# Run sh and ignore exception
def run_sh cmd
  begin; sh cmd; rescue; end
end

# Run cmd. On failure run install and try again.
def bash cmd
  sh cmd do |successful, result|
    # exitstatus 7 means bundle install failed
    # exitstatus 1 means the test failed
    if !successful && result.exitstatus === 7
      Rake::Task['install'].execute
      run_sh cmd
    end
  end
end

# Run a single test with:
# rake ios['ios/element/generic']
#
# rake ios['driver']
#
# Run all tests with:
# rake ios
desc 'Run the iOS tests'
task :ios, :args, :test_file do |args, test_file|
  # rake android['ok']
  # args = android
  # test_file = {:args=>"ok"}
  test_file = test_file[:args]
  path = File.expand_path('appium.txt', Rake.application.original_dir)
  ENV['APPIUM_TXT'] = path
  puts "Rake appium.txt path is: #{path}"
  cmd = 'bundle exec ruby ./lib/run.rb ios'
  cmd += %Q( "#{test_file}") if test_file
  bash cmd
end

desc 'Run bundle install'
task :install do
  sh 'bundle install'
end

# rake command executes ios
task :default => :ios