class MinimumRailsVersion
  class << self
    def satisfied?
      version = Gem::Version.new(Rails::VERSION::STRING)
      requirement = Gem::Requirement.new("~> 7.1.1")

      requirement.satisfied_by?(version)
    end
  end
end
