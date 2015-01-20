module Music
  class Note
    include Comparable

    attr_reader :octave
    
    class InvalidNoteError < StandardError; end
    class InvalidAccidentalError < StandardError; end

    NAMES = {
      "A"  =>  0,
      "A#" =>  1,
      "Bb" =>  1,
      "B"  =>  2,
      "C"  =>  3,
      "C#" =>  4,
      "Db" =>  4,
      "D"  =>  5,
      "D#" =>  6,
      "Eb" =>  6,
      "E"  =>  7,
      "F"  =>  8,
      "F#" =>  9,
      "Gb" =>  9,
      "G"  => 10,
      "G#" => 11,
      "Ab" => 11
    }

    NAMES_FOR_VALUES = {
      sharp: {
         0 => "A",
         1 => "A#",
         2 => "B",
         3 => "C",
         4 => "C#",
         5 => "D",
         6 => "D#",
         7 => "E",
         8 => "F",
         9 => "F#",
        10 => "G",
        11 => "G#"
      },
      flat: {
         0 => "A",
         1 => "Bb",
         2 => "B",
         3 => "C",
         4 => "Db",
         5 => "D",
         6 => "Eb",
         7 => "E",
         8 => "F",
         9 => "Gb",
        10 => "G",
        11 => "Ab"
      }
    }
    def initialize(name, octave)
      if NAMES.has_key?(name)
        @name = name
      else
        raise InvalidNoteError, "Unknown note: \"#{name}\""
      end
      @distance_from_a = NAMES[@name]
      @octave = octave
    end

    def <=>(other)
      octave_compare = octave <=> other.octave
      if octave_compare == 0
        distance_from_c <=> other.send(:distance_from_c)
      else
        octave_compare
      end
    end
    
    def full_name(accidental = nil)
      "#{name_for_accidental(accidental)}#{@octave}"
    end
    
    private

    def distance_from_c
      (@distance_from_a - 3) % 12
    end
    
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
      NAMES_FOR_VALUES[:sharp][@distance_from_a]
    end
    
    def flat_name
      NAMES_FOR_VALUES[:flat][@distance_from_a]
    end
  end
end
