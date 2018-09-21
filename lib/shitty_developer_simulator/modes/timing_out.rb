class ShittyDeveloperSimulator::Modes::TimingOut < ShittyDeveloperSimulator::Modes::Base
  def call(*)
    sleep(15)
    super
  end

  private

  def status
    503
  end
end
