module Gemtext
  class ListItem < Node
    def self.[](content)
      new content
    end
  end
end
