require_relative "madweblibs/version"
require_relative "madweblibs/generator.rb"

module Madweblibs
  class << self
    DEFAULT_ADJECTIVES_COUNT = 3
    DEFAULT_ADVERB_PROBABILITY = 0.20

    def generate
      generator = Generator.new(adjective_count = DEFAULT_ADJECTIVES_COUNT,
                                adverb_probability = DEFAULT_ADVERB_PROBABILITY)
      puts generator.generate
    end
  end
end

