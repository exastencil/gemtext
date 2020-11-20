module Gemtext
  class SubHeading < Node
    def self.[](content)
      new content
    end

    def inspect
      "#{self.class}{#{content}}"
    end
  end
end
