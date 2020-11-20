module Gemtext
  class Preformatted < Node
    def initialize(content, caption = nil)
      super content
      @caption = caption
    end

    def self.[](content, caption = nil)
      new content, caption
    end

    def inspect
      "#{self.class}{#{content}|{#{@caption}}"
    end
  end
end
