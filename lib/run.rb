require 'rubygems'
require 'selenium-webdriver'
require 'spec' # https://github.com/appium/spec
require 'page-object'
require 'test_runner'

opts = Appium.load_appium_txt file: File.expand_path('..', __FILE__), verbose: true
Appium::Driver.new(opts).start_driver

# load page objects
require_relative 'pages/buttons_page'

# ruby core
require 'singleton'

# attach page object methods & make them singletons
Pages.constants.each do |page_class|
  # set page name before the class is fully qualified.
  # ButtonsPage => buttons_page
  page_name = page_class.to_s.gsub(/([a-z])([A-Z])/, '\1_\2').downcase

  # Pages::ButtonsPage
  page_class = Pages.const_get page_class # transform symbol into fully qualified reference

  page_class.include Singleton

  # https://github.com/cheezy/page-object/blob/27c601042b3b7c1c1816b207c41cf43d7be95908/lib/page-object.rb#L59
  page_class.class_eval do
     def initialize
       initialize_browser $driver.driver
     end
  end

  Minitest::Spec.send(:define_method, page_name) do
    page_class.instance
  end
end

# load test
require_relative 'spec/buttons_spec'

Minitest.after_run { $driver.x if $driver }

def run_tests
  # run test
  trace_files = []

  base_path  = File.dirname(__FILE__)
  spec_path  = File.join(base_path, 'spec/**/*.rb')
  pages_path = File.join(base_path, 'pages/**/*.rb')
  Dir.glob(spec_path) do |f|
    trace_files << File.expand_path(f)
  end
  Dir.glob(pages_path) do |f|
    trace_files << File.expand_path(f)
  end

  Minitest.run_specs ({ trace: trace_files })
end

run_tests