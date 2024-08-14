require 'gemtext/document'

module Gemtext
  class Parser
    def initialize(io)
      @io = io
      @document = Document.new
      @preformatted = false
    end

    def parse
      @io.each do |line|
        # Always strip lines to handle "\r\n"
        stripped = line.strip

        # First check if we're toggling preformatted mode
        if stripped =~ /^```/
          if @preformatted
            # Closing out the preformatted text
            @preformatted.content.delete_suffix!("\n") # Remove the extra newline from the last line
            @document.push @preformatted
            @preformatted = false
          elsif stripped == '```'
            # Starting preformatted text without caption
            @preformatted = Preformatted[""]
          else
            # Starting preformatted text with caption
            @preformatted = Preformatted["", stripped.delete_prefix('```').strip]
          end
          next
        end

        # Once we're in a preformatted block add to the block until we
        # break out of it
        if @preformatted
          @preformatted.content << line
          next
        end

        @document.push(
          case stripped
          when /^#\s+/
            Heading[stripped.delete_prefix('#').strip]
          when /^##\s+/
            SubHeading[stripped.delete_prefix('##').strip]
          when /^###\s+/
            SubSubHeading[stripped.delete_prefix('###').strip]
          when ""
            Whitespace[nil]
          when /^=>/
            without_arrow = stripped.delete_prefix('=>').strip
            pieces = without_arrow.split(/\s+/)
            url = pieces.first
            description = pieces.drop(1).join ' ' # TODO: Preserve whitespace in description

            Link[url, description]
          when /^\*\s/
            ListItem[stripped.delete_prefix('*').strip]
          when /^>/
            Quote[stripped.delete_prefix('>').strip]
          else
            Text[line.strip]
          end
        )
      end
    @document.dup
    end
  end
end
