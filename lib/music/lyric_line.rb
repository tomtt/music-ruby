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

    def add_segments(segments, chord, lyric)
      lyrics_split_in_words = lyric.split(/\b/)
      if lyrics_split_in_words[0].blank? && lyrics_split_in_words.size > 1
        segments << {
          lyric: lyrics_split_in_words.shift,
          chord: chord
        }
        segments << {
          lyric: lyrics_split_in_words.join(''),
          chord: nil
        }
      else
        segments << {
          lyric: lyric,
          chord: chord
        }
      end
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
          add_segments(segments, current_chord[:name], lyric_segment(current_chord[:position], chord[:position]))
          current_chord = chord
        end
        add_segments(segments, current_chord[:name], lyric_segment(current_chord[:position]))
        segments
      end
    end
  end
end
