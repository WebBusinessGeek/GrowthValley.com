require 'capybara/dsl'

Capybara.javascript_driver = :webkit

RSpec.configure do |c|
  c.include Capybara::DSL, example_group: {
    file_path: /\bspec\/request\//
  }
end