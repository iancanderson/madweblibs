require_relative "madweblibs/version"
require_relative "madweblibs/generator.rb"

module Madweblibs
  class << self
    DEFAULT_ADJECTIVES_COUNT = 3
    DEFAULT_ADVERB_PROBABILITY = 0.20

    def generate(adjective_count = DEFAULT_ADJECTIVES_COUNT,
                 adverb_probability = DEFAULT_ADVERB_PROBABILITY)
      generator = Generator.new(adjective_count, adverb_probability)
      generator.generate
    end
  end
end

