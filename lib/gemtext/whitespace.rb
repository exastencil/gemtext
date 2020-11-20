module Gemtext
  class Whitespace < Node
    def self.[](content)
      new content
    end
  end
end
