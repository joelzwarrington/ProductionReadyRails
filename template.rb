require "fileutils"

def apply_template!
  setup
  raise "ERROR: This template requires Rails '~> 7.1.1', you're using #{MinimumRailsVersion.current_version}" unless MinimumRailsVersion.satisfied?
  raise "Using invalid application options" unless RequiredOptions.valid?(options)

  template "templates/Gemfile.tt", force: true
end

def setup
  add_template_repository_to_source_path
  require_relative "lib/minimum_rails_version"
  require_relative "lib/required_options"
end

def add_template_repository_to_source_path
  if __FILE__.match?(%r{\Ahttps?://})
    source_paths.unshift(tempdir = Dir.mktmpdir("rails-template-"))
    at_exit { FileUtils.remove_entry(tempdir) }
    git clone: [
      "--quiet",
      "https://github.com/joelzwarrington/ProductionReadyRails",
      tempdir
    ].map(&:shellescape).join(" ")
  else
    source_paths.unshift(File.dirname(__FILE__))
  end
end

apply_template!
