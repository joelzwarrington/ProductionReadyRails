class MinimumRailsVersion
  class << self
    def satisfied?
      version = Gem::Version.new(current_version)
      requirement = Gem::Requirement.new("~> 7.1.1")

      requirement.satisfied_by?(version)
    end

    def current_version
      Rails::VERSION::STRING
    end
  end
end
