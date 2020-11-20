module Gemtext
  # `Gemtext::Node` represents a piece of a document. There are
  # a limited number of node types. They store their content with any
  # formatting needed to identify that content removed.
  class Node
    # The content of the node
    attr_reader :content

    def initialize(content = nil)
      @content = content
    end

    def inspect
      "#{self.class}{#{content}}"
    end

    def ==(other)
      other.class == self.class && other.content == @content
    end
  end
end
