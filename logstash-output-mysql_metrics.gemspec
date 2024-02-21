Gem::Specification.new do |s|
  s.name          = 'logstash-output-mysql_metrics'
  s.version       = '0.1.0'
  s.licenses      = ['Apache-2.0']
  s.summary       = 'Logstash Output Plugin for MySQL Metrics'
  s.description   = 'This plugin logs metrics about MySQL pipeline processing to a specified file, enabling further processing or visualization of these metrics outside of Logstash.'
  s.homepage      = 'http://example.com/logstash-output-mysql_metrics'
  s.authors       = ['Your Name']
  s.email         = 'your_email@example.com'
  s.require_paths = ['lib']

  # Files
  s.files = Dir['lib/**/*','spec/**/*','vendor/**/*','*.gemspec','*.md','CONTRIBUTORS','Gemfile','LICENSE','NOTICE.TXT']
  # Tests
  s.test_files = s.files.grep(%r{^(test|spec|features)/})

  # Special flag to let us know this is actually a logstash plugin
  s.metadata = { "logstash_plugin" => "true", "logstash_group" => "output" }

  # Gem dependencies
  s.add_runtime_dependency "logstash-core-plugin-api", "~> 2.0"
  s.add_runtime_dependency "logstash-codec-plain"
  s.add_development_dependency "logstash-devutils"
end
