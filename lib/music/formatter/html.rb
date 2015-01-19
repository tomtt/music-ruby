module Music
  module Formatter
    class HTML < Base
      def render
        lines = @chord_sheet.lines
        output = ""
        lines.each do |line|
          line.segments.each do |segment|
            lyric = segment[:lyric]
            chord = segment[:chord]
            if chord
              output += "<b>(#{chord})</b>"
            end
            output += lyric.gsub(/(\[[^\]]*\])/i, '<b>\1</b>')
          end
          output += "<br>\n"
        end
        output
      end
    end
  end
end
