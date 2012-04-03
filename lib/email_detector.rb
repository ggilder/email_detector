require "email_detector/version"
require "email_detector/detector"

module EmailDetector
  def self.new *args
    Detector.new *args
  end
end
