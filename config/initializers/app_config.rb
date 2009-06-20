require 'erb'
require 'ostruct'
require 'yaml'

# Load application configuration
AppConfig = OpenStruct.new(
  YAML.load(
    ERB.new(
      File.read(File.join(RAILS_ROOT, "config", "application.yml"))
    ).result
  )[ENV['RAILS_ENV']]
)
