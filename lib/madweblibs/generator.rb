require 'linguistics'
Linguistics::use( :en )

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
      @adjectives = ADJECTIVES.sample(@adjective_count).map do |adjective|
        rand < @adverb_probability ? "#{ADVERBS.sample}-#{adjective}" : adjective
      end
      @database = DATABASES.sample
      @noun1 = NOUNS1.sample
      @noun2 = NOUNS2.sample
      @platform = PLATFORMS.keys.sample
    end
    def shortname_component(string)
      component = if PLATFORMS.key? string.to_sym
        PLATFORMS[string.to_sym]
      else
        string[0..2]
      end
      component.capitalize
    end
    def generate_shortname
      [@database, @platform, @noun1].map do |string|
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
      "#{@database}-backed"
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
    ADVERBS = %w{
      awesomely
      fully
      highly
      incredibly
      readily
      semantically
      syntactically
      wonderfully
    }
    ADJECTIVES = %w{
      accessible
      asynchronous
      awesome
      beautiful
      consistent
      customizable
      dead-simple
      distributed
      DRY
      durable
      dynamic
      eager-loading
      encrypted
      flexible
      free-as-in-beer
      free-as-in-speech
      full-stack
      functional
      highly-optimized
      lazy-loading
      little
      localized
      modular
      object-oriented
      parallel
      scalable
      schemaless
      semantic
      social
      static
      test-driven
      turing-complete
      type-safe
      unfancy
      web-scale
    }
    DATABASES = %w{
      bigtable
      cassandra
      cloud
      couch-db
      memory
      mongo
      postgres
      redis
      yaml
    }
    NOUNS1 = [
      'canvas',
      'css',
      'fibers',
      'factories',
      'fixtures',
      'HTML5',
      'javascript',
      'key-value store',
      'message queue',
      'web-socket',
      'web font'
    ]
    NOUNS2 = [
      'adapter',
      'client',
      'cms',
      'crm',
      'dsl',
      'extension',
      'framework',
      'generator',
      'interface',
      'middleware',
      'orm',
      'parser',
      'plugin',
      'pre-compiler',
      'replacement',
      'state machine',
      'toolkit',
      'wrapper'
    ]
    PLATFORMS = {
      ActiveRecord: 'active',
      capistrano: 'cap',
      clojure: 'cloj',
      Django: 'jang',
      emacs: 'macs',
      Erlang: 'erl',
      gopher: 'goph',
      groovy: 'groo',
      hadoop: 'doop',
      haskell: 'hask',
      javascript: 'java',
      json: 'jas',
      lua: 'lu',
      NodeJs: 'node',
      python: 'py',
      rails: 'rail',
      ruby: 'ru',
      rvm: 'rev',
      sass: 'sassy',
      scala: 'scal',
      sinatra: 'sin',
      TextMate2: 'mate',
      vim: 'vim'
    }
  end
end

