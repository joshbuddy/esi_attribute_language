require File.join(File.dirname(__FILE__), 'esi_attribute_language', 'grammar')

module EsiAttributeLanguage

  class VariableLookup
    def initialize(variable_name)
      @variable_name = variable_name.to_sym
    end
    
    def execute(context)
      context[@variable_name]
    end
  end

  class Node
    def self.cleanse_string(string)
      if string[0] == ?' && string[-1] == ?'
        string[1, string.size - 2].gsub('\\\'', '\'')
      else
        string
      end
    end
    
    def result_single(var, context)
      var.respond_to?(:execute) ? var.execute(context) : var
    end

    def result(var, context)
      var.is_a?(Array) ? var.map{|v| result_single(v, context)} : result_single(var, context)
    end
  end
  
  class ConcatNode < Node
    def initialize(*parts)
      @parts = parts
    end
    
    def execute(context)
      result(@parts, context).join('')
    end
  end
  
  class HashLookupNode < Node
    def initialize(variable, key)
      
      @variable = variable
      @key = key
    end
    
    def execute(context)
      case var = result(@variable, context)
      when Hash
        var[result(@key, context)]
      when Set
        var.include?(result(@key, context))
      end
    end
  end
  
  class OrNode < Node
    def initialize(lval, rval)
      @lval = lval
      @rval = rval
    end
    
    def execute(context)
      result(@lval, context) || result(@rval, context)
    end
    
  end

  class DummyNode < Node
    def initialize(lit)
      @lit = lit
    end
    
    def execute(context)
      @lit
    end
  end

  class MethodNode < Node
    def initialize(receiver, op, *args)
      @receiver = receiver
      @op = op
      @args = args
    end

    def execute(context)
      result(@receiver, context).send(@op, *result(@args, context))
    end
  end

end