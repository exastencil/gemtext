require 'gemtext/node'
require 'gemtext/heading'
require 'gemtext/sub_heading'
require 'gemtext/sub_sub_heading'
require 'gemtext/whitespace'
require 'gemtext/text'
require 'gemtext/list_item'
require 'gemtext/link'
require 'gemtext/preformatted'
require 'gemtext/quote'

module Gemtext
  # `Gemtext::Document` represents a gemtext document or "page". It
  # consists of a sequence of `Gemtext::Node`s
  class Document
    # Nodes
    attr_reader :nodes

    def initialize
      @nodes = []
    end

    def push(node)
      @nodes << node if node.is_a? Gemtext::Node
    end
  end
end
