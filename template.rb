require "fileutils"

def apply_template!
  setup
  template "templates/README.md.tt", force: true
  template "templates/ruby-version.tt", ".ruby-version", force: true
  template "templates/Gemfile.tt", "Gemfile", force: true
  copy_file "templates/Procfile.dev", "Procfile.dev"

  after_bundle do
    run "bin/standardrb > /dev/null"
  end
end

def setup
  add_template_repository_to_source_path
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
