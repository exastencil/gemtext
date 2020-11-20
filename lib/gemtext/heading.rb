module Gemtext
  class Heading < Node
    def self.[](content)
      new content
    end
  end
end
