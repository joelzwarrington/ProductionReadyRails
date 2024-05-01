class RequiredOptions
  class << self
    def valid_options
      {
        skip_gemfile: false,
        skip_bundle: false,
        skip_git: false,
        skip_test_unit: true,
        skip_active_storage: false,
        skip_javascript: true,
        skip_docker: true,
        edge: false
      }
    end

    def valid?(options)
      valid = options.to_a & valid_options.to_a
      invalid_option_keys = (valid_options.to_a - valid).map(&:first)

      invalid_option_keys.empty?
    end
  end
end
