# frozen_string_literal: true

require 'test_helper'

class GemtextTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Gemtext::VERSION
  end

  def test_parsing_from_a_string
    gmi = <<-TXT
      # This is a heading
      ## This is a subheading
      ### This is a subsubheading

      This is some normal text.
      * This
      * Is
      * A
      * List
      > To be, or not to be...
      ```formatted
      some text
      ```
      => gemini.circumlunar.space Gemini
    TXT

    document = Gemtext.parse(gmi)
    refute_nil document

    assert_equal [
      Gemtext::Heading['This is a heading'],
      Gemtext::SubHeading['This is a subheading'],
      Gemtext::SubSubHeading['This is a subsubheading'],
      Gemtext::Whitespace[nil],
      Gemtext::Text['This is some normal text.'],
      Gemtext::ListItem['This'],
      Gemtext::ListItem['Is'],
      Gemtext::ListItem['A'],
      Gemtext::ListItem['List'],
      Gemtext::Quote['To be, or not to be...'],
      Gemtext::Preformatted['      some text', 'formatted'],
      Gemtext::Link['gemini.circumlunar.space', 'Gemini']
    ].to_s, document.nodes.to_s
  end

  def test_parsing_from_a_file
    document = Gemtext.parse File.open('test/simple.gmi')
    refute_nil document
    assert_instance_of Gemtext::Document, document

    assert_equal [
      Gemtext::Heading['Heading'],
      Gemtext::SubHeading['Heading 2'],
      Gemtext::SubSubHeading['Heading 3'],
      Gemtext::Whitespace[nil],
      Gemtext::Text['Just text'],
      Gemtext::ListItem['Lonely item'],
      Gemtext::Quote['I said it'],
      Gemtext::Preformatted['Preformatted', 'Caption'],
      Gemtext::Link['gemini.circumlunar.space', 'Gemini']
    ].to_s, document.nodes.to_s
  end

  def test_pattern_matching_on_nodes
    node = Gemtext::Heading['Heading']

    assert_equal case node # is a Node
                 in Gemtext::Heading[content:] # subclass of Node
                   "\\section{#{content}}\n"
                 in Gemtext::Link[target:, description:]
                   "#{description} (\\url{#{target}})\n"
                 end,
                 "\\section{Heading}\n"
  end
end
