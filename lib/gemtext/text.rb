module Gemtext
  class Text < Node
    def self.[](content)
      new content
    end

    def ==(other)
      other.class == self.class && other.content == @content
    end
  end
end
