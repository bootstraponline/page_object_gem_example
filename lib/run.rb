# -- gems
require 'rubygems'
require 'selenium-webdriver'
require 'spec' # https://github.com/bootstraponline/spec
require 'page-object'
require 'test_runner'
# --

load_appium_txt file: File.expand_path('..',__FILE__), verbose: true
Appium::Driver.new(debug: true, wait: 30).start_driver

# load page objects
require_relative 'pages/buttons'

$pages_buttons_obj = Pages::Buttons.new $driver.driver

module Kernel
  def buttons
    $pages_buttons_obj
  end
end

# load test
require_relative 'spec/buttons'

Minitest.after_run { $driver.x if $driver }

def run_tests
  # run test
  trace_files = []

  base_path = File.dirname(__FILE__)
  spec_path = File.join(base_path, 'spec/**/*.rb')
  pages_path = File.join(base_path, 'pages/**/*.rb')
  Dir.glob(spec_path) do |f|
    trace_files << File.expand_path(f)
  end
  Dir.glob(pages_path) do |f|
    trace_files << File.expand_path(f)
  end

  Minitest.run_specs ({trace: trace_files})
end

run_tests