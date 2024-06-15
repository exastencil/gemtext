module Gemtext
  class Link < Node
    attr_reader :description
    attr_reader :target

    def initialize(content)
      super content
      @target = @content.split(/\s+/).first
      @description = content.delete_prefix(@target).strip
    end

    def self.[](target, description = nil)
      new "#{target} #{description}"
    end

    def ==(other)
      other.class == self.class && other.target == @target && other.description == @description
    end

    def deconstruct_keys(*_keys)
      { **super, target:, description: }
    end
  end
end
