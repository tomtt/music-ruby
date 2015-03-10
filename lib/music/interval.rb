module Music
  class Interval
    attr_reader :from, :to

    TYPE_FOR_DISTANCE = {
      0 => :unison,
      1 => :minor_second,
      2 => :major_second,
      3 => :minor_third,
      4 => :major_third,
      5 => :perfect_fourth,
      6 => :tritone,
      7 => :perfect_fifth,
      8 => :minor_sixth,
      9 => :major_sixth,
      10 => :minor_seventh,
      11 => :major_seventh,
      12 => :octave,
      13 => :minor_ninth,
      14 => :major_ninth
    }
    
    def self.between_notes(from, to)
      new(from, to)
    end

    def distance
      to.distance_from_c0 - from.distance_from_c0
    end

    def direction
      if to == from
        :unison
      elsif to > from
        :ascending
      else
        :descending
      end
    end
    
    def type
      TYPE_FOR_DISTANCE[distance.abs]
    end
    
    private

    def initialize(from, to)
      @from = from
      @to = to
    end
  end
end
