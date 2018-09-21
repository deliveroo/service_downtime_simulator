module ShittyDeveloperSimulator
  class Config
    WonkyInputError = Class.new(StandardError)

    OPTIONS = %i[
      enabled
      mode
      logger
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
      if @mode.nil? || @mode.empty?
        moan(:mode, 'No mode provided')
        return nil
      end

      unless @mode.is_a?(Symbol)
        moan(:mode, 'Mode must be a symbol')
        return nil
      end

      unless ShittyDeveloperSimulator::Modes.exists?(@mode)
        moan(:mode, "Unknown mode #{@mode}")
        return nil
      end

      @mode
    end

    def mode_klass
      ShittyDeveloperSimulator::Modes.for(mode)
    end

    private

    def moan(option, message)
      return unless logger.respond_to?(:error)

      logger.error("[SDS] Issue with #{option}: #{message}. Will not activate unless fixed.")
    end
  end
end
