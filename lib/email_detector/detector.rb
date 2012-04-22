require 'forwardable'

module EmailDetector
  class Detector
    extend Forwardable
    include Enumerable

    attr_reader :ignored

    # delegate to_a, each, empty? to the @list ivar
    def_delegators :@list, :to_a, :each, :empty?, :join

    def initialize input
      self.emails = input
    end

    def emails= input
      @ignored = []
      input ||= ''
      input = input.join(', ') if input.respond_to?(:join)

      pattern = /(?<=\A|[<\s,])[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,3}(?=[>,\s]|\Z)/i
      @list = input.scan(pattern).map(&:downcase).uniq
      @ignored = input.split(pattern).map {|e| e.gsub(/\A[,<>\s]+|[,<>\s]+\z/, '')}
      @ignored.delete_if(&:empty?)
    end

    def emails
      @list.join(", ")
    end
    alias :to_s :emails

    def + other
      self.class.new(to_a + other.to_a)
    end

    def == other
      to_a == Array(other)
    end
  end
end
