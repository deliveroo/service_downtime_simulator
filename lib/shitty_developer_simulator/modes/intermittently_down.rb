class ShittyDeveloperSimulator::Modes::IntermittentlyDown < ShittyDeveloperSimulator::Modes::Base
  def call(env)
    unless knackered?
      return app.call(env)
    end

    super
  end

  private

  def status
    500
  end

  def knackered?
    [true, false].sample
  end
end
