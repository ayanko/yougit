require 'erb'
require 'ostruct'
require 'yaml'

# Load application configuration
config_file = File.join(RAILS_ROOT, "config", "application.yml")

abort("Please create #{config_file}") unless File.exists?(config_file)

AppConfig = OpenStruct.new(
  YAML.load(
    ERB.new(
      File.read(config_file)
    ).result
  )[ENV['RAILS_ENV']]
)
