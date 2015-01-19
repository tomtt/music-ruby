module Music
  class LyricLine
    def lyricline=(lyricline)
      @lyricline = lyricline
      if @chordline && @lyricline.size < @chordline.size
        @lyricline += " " * (@chordline.size - @lyricline.size)
      end
    end

    def chordline=(chordline)
      @chordline = chordline
      raise "assign chordline before lyricline" if @lyricline
      @chords = Music::ChordlineParser.new(chordline)
    end

    def chords
      if @chords
        @chords.chords
      else
        []
      end
    end

    def lyric_segment(start, stop_before = nil)
      if stop_before
        stop_before -= 1
      else
        stop_before = -1
      end

      @lyricline[start..stop_before]
    end
    
    def segments
      self.lyricline = "" unless @lyricline
      chord_list = chords.dup
      if chord_list.empty?
        [{lyric: @lyricline, chord: nil}]
      else
        segments = []
        current_chord = chord_list.shift
        if current_chord[:position] > 0
          segments << {
            lyric: lyric_segment(0, current_chord[:position]),
            chord: nil
          }
        end

        chord_list.each do |chord|
          segments << {
            lyric: lyric_segment(current_chord[:position], chord[:position]),
            chord: current_chord[:name]
          }
          current_chord = chord
        end
        segments << {
          lyric: lyric_segment(current_chord[:position]),
          chord: current_chord[:name]
        }
        segments
      end
    end
  end
end
