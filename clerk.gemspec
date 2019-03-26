# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'clerk/version'

Gem::Specification.new do |spec|
  spec.name          = 'clerk'
  spec.version       = Clerk::VERSION
  spec.authors       = ['Kyle Zhao']
  spec.email         = ['kzhao.sw@gmail.com']

  spec.summary       = "Manage University of Waterloo's exam and test schedules."
  spec.homepage      = 'https://github.com/uwwe/exam_calendar_clerk'
  spec.license       = 'MIT'

  raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.' unless spec.respond_to?(:metadata)

  # arbitrary host to prevent pushing this gem to RubyGems.org
  spec.metadata['allowed_push_host'] = 'https://gemserver.uwwe.ca'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/uwwe/exam_calendar_clerk'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = ['clerk']
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.17'
  spec.add_development_dependency 'byebug', '~> 10.0.2'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.60.0'
  spec.add_development_dependency 'webmock', '~> 3.5.1'

  spec.add_dependency 'httparty', '~> 0.16.2'
  spec.add_dependency 'thor', '~> 0.20.3'
end
