module Music
  class ChordlineParser

    @@match_accidental = '[b#]'
    @@match_note = "[A-G]#{@@match_accidental}?"
    @@match_mode = '(?:major|minor|maj|min|m|o|dim|aug|\+)?'
    @@match_modify = "(?:[0-9][0-3]?(?:-[0-9])?)?(?:sus[24]?)?(?:#{@@match_accidental}[1-9][0-3]?)?"
    @@match_bassnote = "(?:\/#{@@match_note})?"
    @@match_comment = '(?:\([^\)]*\))?'
    @@match_nochord = '(?i:n\/c)|(?i:no chords)|(?i:n\.?c\.?)'
    @@match_chord = /(?:#{@@match_note}#{@@match_mode}#{@@match_modify}#{@@match_bassnote}#{@@match_comment})|#{@@match_nochord}/
    @@match_empty = /\s+/

    def initialize(line)
      @line = StringScanner.new line
    end

    def chords
      @chords ||= parse_chords
    end

    def self.is_chord_line?(line)
      !(new(line).chords.empty?)
    end

    private

    def parse_chords
      @chords = []
      @line.skip @@match_empty
      until(@line.eos?)
        current_pos = @line.charpos
        chord = @line.scan @@match_chord
        if chord
          @chords << { position: current_pos, name: chord }
        else
          return []
        end
        @line.skip @@match_empty
      end
      return @chords
    end
  end
end
