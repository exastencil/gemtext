require "test_helper"

class ParserTest < Minitest::Test
  def test_parsing_a_simple_document
    parser = Gemtext::Parser.new File.open('test/simple.gmi')
    document = parser.parse
    refute_nil document
    assert_instance_of Gemtext::Document, document

    assert_equal [
      Gemtext::Heading["Heading"],
      Gemtext::SubHeading["Heading 2"],
      Gemtext::SubSubHeading["Heading 3"],
      Gemtext::Whitespace[nil],
      Gemtext::Text["Just text"],
      Gemtext::ListItem["Lonely item"],
      Gemtext::Quote["I said it"],
      Gemtext::Preformatted["Preformatted", 'Caption'],
      Gemtext::Link["gemini.circumlunar.space", "Gemini"]
    ].to_s, document.nodes.to_s
  end

  def test_that_it_parses_the_fixture
    document = nil
    File.open 'test/fixture.gmi' do |io|
      parser = Gemtext::Parser.new io
      document = parser.parse
    end

    refute_nil document

    assert_instance_of Gemtext::Document, document

    nodes = [
      Gemtext::Heading[%{A quick introduction to "gemtext" markup}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{The most common way to serve textual content over Gemini is not just plain text like on Gopher, but using a lightweight markup language called "Gemtext" (which is served with the unofficial MIME type text/gemini).  This document is a quick introduction to that markup language.  It has some superficial resemblences to Markdown, which will make it easy to learn if you know MD, but it's quite different in other ways.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Once you've read this document, you might like to occasionally refresh your memory by refering to the:}],
      Gemtext::Whitespace[nil],
      Gemtext::Link["cheatsheet.gmi", "Gemtext cheatsheet"],
      Gemtext::Whitespace[nil],
      Gemtext::SubHeading[%{Text}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Text in Gemtext documents is written using "long lines", i.e. you (or your editor) shouldn't be inserting newline characters every 80 characters or so.  Instead, leave it up to the receiving Gemini client to wrap your lines to fit the device's screen size and the user's preference.  This way Gemtext content looks good and is easy to read on desktop monitors, laptop screens, tablets and smartphones.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Note that while Gemini clients will break up lines of text which are longer than the user's screen, they will not join up lines which are shorter than the user's screen, like would happen in Markdown, HTML or LaTeX.  This means that, e.g. "dot point" lists or poems with deliberately short lines will be displayed correctly without the author having to do any extra work or the client having to be any smarter in order to recognise and handle that kind of content corectly.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{For most "everyday" writing, this approach means you probably just want to use one line per paragraph.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Note that blank lines are rendered verbatim by clients verbatim, i.e. if you put two or three blank lines between your paragraphs, the reader will see two or three blank lines.}],
      Gemtext::Whitespace[nil],
      Gemtext::SubHeading[%{Links}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Like Gopher (and unlike Markdown or HTML), Gemtext only lets you put links to other documents on a line of their own.  You can't make a single word in the middle of a sentence into a link.  This takes a little getting used to, but it means that links are extremely easy to find, and clients can style them differently (e.g. to make it clear which protocol they use, or to display the domain name to help users decide whether they want to follow them or not) without interfering with the readability of your actual textual content.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Link lines look like this:}],
      Gemtext::Whitespace[nil],
      Gemtext::Preformatted[%{=> https://example.com    A cool website\n=> gopher://example.com   An even cooler gopherhole\n=> gemini://example.com   A supremely cool Gemini capsule\n=> sftp://example.com}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{That is:}],
      Gemtext::Whitespace[nil],
      Gemtext::ListItem[%{They start with the two characters =>,}],
      Gemtext::ListItem[%{followed by optional whitespace (spaces or tabs, as many or as few as you like),}],
      Gemtext::ListItem[%{followed by a URL (any protocol you like).}],
      Gemtext::ListItem[%{They can end right there if you like, as per the sftp example above!}],
      Gemtext::ListItem[%{Or they can be followed by at least one space or tab,}],
      Gemtext::ListItem[%{And then a human-friendly label, which can be as long as you like}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{In the above example, all the URLs and labels lined up nicely because the author was pedantic.  But Gemini doesn't care, and this is fine too:}],
      Gemtext::Whitespace[nil],
      Gemtext::Preformatted[%{=>https://example.com A cool website\n=>gopher://example.com      An even cooler gopherhole\n=> gemini://example.com A supremely cool Gemini capsule\n=>   sftp://example.com}],
      Gemtext::Whitespace[nil],
      Gemtext::Link["https://example.com", "A cool website"],
      Gemtext::Link["gopher://example.com", "An even cooler gopherhole"],
      Gemtext::Link["gemini://example.com", "A supremely cool Gemini capsule"],
      Gemtext::Link["sftp://example.com"],
      Gemtext::Whitespace[nil],
      Gemtext::SubHeading[%{Headings}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Gemtext supports three levels of headings.  Headings are limited to a single line and start with either one, two or three # symbols followed by one mandatory space character:}],
      Gemtext::Whitespace[nil],
      Gemtext::Preformatted[%{# Heading\n\n## Sub-heading\n\n### Sub-sub-heading}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{This is the only supported heading syntax.  Underlining your headings using - or = symbols like in Markdown will not do anything.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{It is strictly optional for clients to do anything special at all with headings.  Many clients will recognise them and use a larger font or a different colour or some other kind of styling, but some will not and will just treat them as ordinary text lines and print them as is.  This is fine, because headings are not supposed to be used to control the appearance of your content.  Rather, they supply important semantic information on the structure of your content.  Some clients will use headings to automatically generate a table of contents for their user, which can be useful for navigating large documents.  Software for generating Atom or RSS feeds might use headings to automatically detect the titles for gemlog posts.}],
      Gemtext::Whitespace[nil],
      Gemtext::SubHeading[%{Lists}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Gemtext supports unordered lists.  Each item in a list is written as a single long line, which begins with a single * symbol followed by one mandatory space character:}],
      Gemtext::Whitespace[nil],
      Gemtext::Preformatted[%{* Mercury\n* Gemini\n* Apollo}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{This is the only supported list syntax.  Using - instead of * like in Markdown will not do anything.  Nested lists are not supported.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{It is strictly optional for clients to do anything special at all with list items, and some clients will treat them just like any other line of text. The only reason they are defined is so that more advanced clients can replace the * with a nicer looking bullet symbol and so when list items which are too long to fit on the device screen get broken across multiple lines, the lines after the first one can be offset from the margin by the same amount of space as the bullet symbol. It's just a typographic nicety.}],
      Gemtext::Whitespace[nil],
      Gemtext::SubHeading[%{Blockquotes}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Gemtext supports blockquotes.  The quoted content is written as a single long line, which begins with a single > character:}],
      Gemtext::Whitespace[nil],
      Gemtext::Preformatted[%{> Gemtext supports blockquotes.  The quoted content is written as a single long line, which begins with a single > character}],
      Gemtext::Whitespace[nil],
      Gemtext::Quote[%{Gemtext supports blockquotes.  The quoted content is written as a single long line, which begins with a single > character}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{It is strictly optional for clients to do anything special at all with blockquotes, and some clients will treat them just like any other line of text.  As per list items, they are defined strictly to allow for more pleasant typography in ambitious clients.}],
      Gemtext::Whitespace[nil],
      Gemtext::SubHeading[%{Preformatted text}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Gemtext is carefully designed to be very, very easy to parse and render.  Gemini clients process Gemtext one line at a time, rendering each line independently of any lines before it or after it, just by peeking at the first few characters of a line to check for something like =>, # , * , etc.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{A line which starts with ``` (i.e. with three backticks) tells the client to toggle between its ordinary parsing mode, and "preformatted mode".  In preformatted mode, clients don't check whether or not a line is a link or a heading or anything else.  They are simply printed as-is.  Also, while clients may use variable width fonts for ordinary all other text, in preformatted mode clients must use a fixed width font.  Thus, a pair of ``` lines acts much like <pre> and </pre> tags in HTML.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Preformatted text can be used to include ASCII art, source code, or similar content in a Gemtext document without clients mistakenly interpreting lines as headings, list items, etc.  It can also be used to write documents like this one, which explain Gemtext syntax with examples - you're able to see the syntax examples above without your client interpreting them like it normally would because they are rendered in preformatted mode.}],
      Gemtext::Whitespace[nil],
      Gemtext::Text[%{Anything which comes after the ``` characters of a line which toggles preformatted line *on* (i.e. the first, third, fifth, etc. toggling lines in a document) may be treated as "alt text" for the preformatted content.  In general you should not count on this content being visible to the user but, for example, search engines may index it and screen readers may read it to users to help the user decide whether the preformatted content should be read aloud (which e.g. ASCII art generally should not be, but which source code perhaps should be).  There are currently no established conventions on how alt text should be formatted.}],
      Gemtext::Whitespace[nil],
    ]

    # This assertion is like this to make it easier to find causes of
    # failures
    assert_equal(
      nodes.to_s.split('Gemtext::').join("\n"),
      document.nodes.to_s.split('Gemtext::').join("\n")
    )
  end
end
