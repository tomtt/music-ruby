module Music
  class ChordSheet
    def self.parse(raw_text)
      new(raw_text)
    end

    def lyrics
      lines = @raw_text.split("\n")
      lyrics = []
      lines.each do |line|
        if line =~ /^[\s]*$/
          lyrics << :empty
        elsif ChordlineParser.new(line).chords.empty?
          lyrics << line.strip
        end
      end

      output = ""
      
      lyrics.each_with_index do |line, index|
        if line == :empty
          if lyrics[index - 1] == :empty || index == 0
            next
          else
            output << "\n"
          end
        else
          output << line.gsub(/[\s]+/, " ") + "\n"
        end
      end
      output
    end

    def lines
      state = :default
      raw_lines = @raw_text.split("\n")
      lines = []
      current_lyric_line = nil
      raw_lines.each do |raw_line|
        if Music::ChordlineParser.is_chord_line?(raw_line)
          if current_lyric_line
            lines << current_lyric_line
          end
          current_lyric_line = Music::LyricLine.new
          current_lyric_line.chordline = raw_line
        else # No chords on current line
          if !current_lyric_line
            current_lyric_line = Music::LyricLine.new
          end
          current_lyric_line.lyricline = raw_line
          lines << current_lyric_line
          current_lyric_line = nil
        end
      end
      if current_lyric_line
        lines << current_lyric_line
      end
      lines
    end
    
    private

    def initialize(raw_text)
      @raw_text = raw_text
    end
  end
end
