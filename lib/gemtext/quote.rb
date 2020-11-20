module Gemtext
  class Quote < Node
    def self.[](content)
      new content
    end
  end
end
