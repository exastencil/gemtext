# frozen_string_literal: true

require 'gemtext/version'
require 'gemtext/parser'
require 'stringio'

module Gemtext
  class Error < StandardError; end

  def self.parse(data)
    io = data
    io = StringIO.new(data) if data.instance_of? String
    parser = Parser.new(io)
    parser.parse
  end
end
