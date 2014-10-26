module Music
  class ChordlineParser

    ACCIDENTAL_REGEXP = '[b#]'
    NOTE_REGEXP = "[A-G]#{ACCIDENTAL_REGEXP}?"
    MODE_REGEXP = "(?:major|minor|maj|min|m)?"
    MODIFY_REGEXP = "(?:o|dim|aug|\\+)?(?:[0-9][0-3]?(?:-[0-9])?)?(?:sus[24]?)?(?:#{ACCIDENTAL_REGEXP}[1-9][0-3]?)?"
    
    BASSNOTE_REGEXP = "(?:\/#{NOTE_REGEXP})?"
    COMMENT_REGEXP = '(?:\([^\)]*\))?'
    NOCHORD_REGEXP = '(?i:n\/c)|(?i:no chords)'
    CHORD_REGEXP = /(?:#{NOTE_REGEXP}#{MODE_REGEXP}#{MODIFY_REGEXP}#{BASSNOTE_REGEXP}#{COMMENT_REGEXP})|#{NOCHORD_REGEXP}/
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
