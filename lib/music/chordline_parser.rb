module Music
  class ChordlineParser

    ACCIDENTAL_REGEXP = "[b#]"
    MODE_REGEXP = "[7]"
    CHORD_REGEXP = /[A-G]#{ACCIDENTAL_REGEXP}?#{MODE_REGEXP}?m?/
    EMPTY_REGEXP = /\s+/
    
    def initialize(line)
      @line = StringScanner.new line
    end

    def chords
      @chords ||= parse_chords
    end

    private

    def parse_chords
      @chords = []
      @line.skip EMPTY_REGEXP
      until(@line.eos?)
        current_pos = @line.charpos
        chord = @line.scan CHORD_REGEXP
        if chord
          @chords << { position: current_pos, name: chord }
        else
          return []
        end
        @line.skip EMPTY_REGEXP
      end
      return @chords
    end
  end
end
