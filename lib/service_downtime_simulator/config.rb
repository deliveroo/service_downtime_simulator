module ServiceDowntimeSimulator
  class Config
    WonkyInputError = Class.new(StandardError)

    OPTIONS = %i[
      enabled
      mode
      logger
      excluded_paths
    ].freeze

    attr_reader :logger

    def self.for(config)
      return config if config.is_a?(self)

      new(config)
    end

    def initialize(config_hash)
      raise WonkyInputError unless config_hash.is_a?(Hash)

      config_hash.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
    end

    def activated?
      enabled == true && !mode.nil?
    end

    def enabled
      @enabled == true
    end

    def mode
      if @mode.nil?
        moan(:mode, 'No mode provided')
        return nil
      end

      unless @mode.is_a?(Symbol)
        moan(:mode, 'Mode must be a symbol')
        return nil
      end

      unless ServiceDowntimeSimulator::Modes.exists?(@mode)
        moan(:mode, "Unknown mode #{@mode}")
        return nil
      end

      @mode
    end

    def mode_klass
      ServiceDowntimeSimulator::Modes.for(mode)
    end

    def excluded_paths
      if @excluded_paths.nil?
        moan(:excluded_paths, 'No excluded paths set. What about your health check endpoint?')
        return []
      end

      unless @excluded_paths.is_a?(Array)
        moan(:excluded_paths, 'Excluded paths must ba an array of paths')
        return []
      end

      # Detect if any elements are not a string
      if @excluded_paths.any? { |el| !el.is_a?(String) }
        moan(:excluded_paths, 'Excluded paths includes non-string value')
        return []
      end

      @excluded_paths
    end

    def path_excluded?(path)
      excluded_paths.include?(path)
    end

    private

    def moan(option, message)
      return unless logger.respond_to?(:error)

      logger.error("[SDS] Issue with #{option}: #{message}. Will not activate unless fixed.")
    end
  end
end
