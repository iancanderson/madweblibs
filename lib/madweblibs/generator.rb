require 'linguistics'
Linguistics::use( :en )
require 'yaml'

module Madweblibs
  class Generator

    def initialize(adjective_count, adverb_probability)
      @adjective_count = adjective_count
      @adverb_probability = adverb_probability
    end

    def generate
      get_random_components
      shortname = generate_shortname
      description = generate_description
      "#{shortname}: #{description}"
    end
    def get_random_components
      @adjectives = adjectives.sample(@adjective_count).map do |adjective|
        rand < @adverb_probability ? "#{adverbs.sample}-#{adjective}" : adjective
      end
      @datastore = datastores.sample
      @noun1 = nouns1.sample
      @noun2 = nouns2.sample
      @platform = platforms.keys.sample
    end
    def shortname_component(string)
      component = if platforms.key? string.to_sym
        platforms[string.to_sym]
      else
        string[0..2]
      end
      component.capitalize
    end
    def generate_shortname
      [@datastore, @platform, @noun1].map do |string|
        shortname_component string
      end.join("") + shortname_suffix
    end
    def shortname_suffix
      %w{
        _fu
        gasm
        ie
        ify
        ist
        ize
        tastic
        ly
      }.sample
    end
    def generate_description
      article = %w{a the}.sample
      desc = "#{adjective_clause} #{storage_clause} #{noun_clause}#{as_a_service_clause} #{platform_clause}."
      if article == 'a'
        first_adjective = desc.split(',').first
        desc.sub!(first_adjective, first_adjective.en.a)
      else
        desc = "#{article} #{desc}"
      end
      desc
    end
    def adjective_clause
      @adjectives.join(', ')
    end
    def storage_clause
      "#{@datastore}-backed"
    end
    def noun_clause
      "#{@noun1} #{@noun2}"
    end
    def as_a_service_clause
      ["-as-a-service", "", "", ""].sample
    end
    def platform_clause
      "for #{@platform}"
    end
    def yaml_hash
      @yaml_hash ||= YAML.load(File.open('lib/word_list.yml'))
    end

    def method_missing(meth, *args, &block)
      # look in the yaml_hash if a method is not defined
      if yaml_hash.key? meth.to_s
        yaml_hash[meth.to_s]
      else
        super
      end
    end
  end
end

