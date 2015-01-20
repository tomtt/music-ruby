module Music
  class Note
    include Comparable

    attr_reader :octave
    
    class InvalidNoteError < StandardError; end
    class InvalidAccidentalError < StandardError; end

    NOTE_NAME_DISTANCES_FROM_C = {
      "A" => 9,
      "A#" => 10,
      "Bb" => 10,
      "B" => 11,
      "C" => 0,
      "C#" => 1,
      "Db" => 1,
      "D" => 2,
      "D#" => 3,
      "Eb" => 3,
      "E" => 4,
      "F" => 5,
      "F#" => 6,
      "Gb" => 6,
      "G" => 7,
      "G#" => 8,
      "Ab" => 8
    }
    
    NAMES_FOR_DISTANCE_FROM_C = {
      sharp: {
        0 => "C",
        1 => "C#",
        2 => "D",
        3 => "D#",
        4 => "E",
        5 => "F",
        6 => "F#",
        7 => "G",
        8 => "G#",
        9 => "A",
        10 => "A#",
        11 => "B"
      },
      flat: {
        0 => "C",
        1 => "Db",
        2 => "D",
        3 => "Eb",
        4 => "E",
        5 => "F",
        6 => "Gb",
        7 => "G",
        8 => "Ab",
        9 => "A",
        10 => "Bb",
        11 => "B"
      }
    }

    def initialize(name, octave)
      if NOTE_NAME_DISTANCES_FROM_C.has_key?(name)
        @name = name
      else
        raise InvalidNoteError, "Unknown note: \"#{name}\""
      end
      @distance_from_c = NOTE_NAME_DISTANCES_FROM_C[@name]
      @octave = octave
    end

    def octave_note_pair
      [octave, @distance_from_c]
    end
    
    def <=>(other)
      octave_note_pair <=> other.octave_note_pair
    end
    
    def full_name(accidental = nil)
      "#{name_for_accidental(accidental)}#{@octave}"
    end
    
    private

    def name_for_accidental(accidental)
      if accidental.to_s == "sharp"
        sharp_name
      elsif accidental.to_s == "flat"
        flat_name
      elsif accidental.blank?
        @name
      else
        raise InvalidAccidentalError, "Unknown accidental: #{accidental}"
      end
    end

    def sharp_name
      NAMES_FOR_DISTANCE_FROM_C[:sharp][@distance_from_c]
    end
    
    def flat_name
      NAMES_FOR_DISTANCE_FROM_C[:flat][@distance_from_c]
    end
  end
end
