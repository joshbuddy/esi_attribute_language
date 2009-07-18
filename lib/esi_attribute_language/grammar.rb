require File.join(File.dirname(__FILE__), 'grammar', 'grammar.y')
require File.join(File.dirname(__FILE__), 'grammar', 'grammar.rex')
require File.join(File.dirname(__FILE__), 'grammar', 'simple.y')
require File.join(File.dirname(__FILE__), 'grammar', 'simple.rex')

module EsiAttributeLanguage

  ParseError = Class.new(Exception)

  class SimpleGrammar
    attr_reader :rules

    def self.parse(source)
      result = SimpleGrammarParser.new.scan_str(source)
      result.respond_to?(:execute) ? result : DummyNode.new(result)
    rescue Racc::ParseError => e
      raise ParseError, e.message
    end

    def initialize(rules)
      @root  = rules.first.name
      @rules = {}
      rules.each { |r| @rules[r.name] = r }
    end

    def parse(string)
      index = @rules[@root].call(string, 0, @rules)
      index if index == string.length
    end
  end

  class Grammar

    attr_reader :rules

    def self.parse(source)
      result = GrammarParser.new.scan_str(source)
      result.respond_to?(:execute) ? result : DummyNode.new(result)
    rescue Racc::ParseError => e
      raise ParseError, e.message
    end

    def initialize(rules)
      @root  = rules.first.name
      @rules = {}
      rules.each { |r| @rules[r.name] = r }
    end

    def parse(string)
      index = @rules[@root].call(string, 0, @rules)
      index if index == string.length
    end

  end
  
end