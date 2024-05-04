require "fileutils"

def apply_template!
  add_template_repository_to_source_path
  require_relative_paths

  puts "MinimumRailsVersion.satisfied?: #{MinimumRailsVersion.satisfied?}"
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

def require_relative_paths
  require_relative "lib/minimum_rails_version"
  require_relative "lib/required_options"
end

apply_template!
