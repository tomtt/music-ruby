require 'spec_helper'

describe Music::LyricLine do
  describe ".segments" do
    it "has only one segment for a lyric with no chords" do
      ll = Music::LyricLine.new
      ll.lyricline = "Some lyric"
      expect(ll.segments).to eq [{lyric: "Some lyric", chord: nil}]
    end

    it "has a segment for each chord" do
      ll = Music::LyricLine.new
      ll.lyricline = "Random words"
      ll.chordline = "G      D    "
      expect(ll.segments).to eq [{lyric: "Random ", chord: "G"}, {lyric: "words", chord: "D"}]
    end

    it "has a segment without lyrics for chords before line" do
      ll = Music::LyricLine.new
      ll.lyricline = "       Fall Down"
      ll.chordline = "G      C    D   "
      expect(ll.segments).to eq [{lyric: "       ", chord: "G"},
                                 {lyric: "Fall ", chord: "C"},
                                 {lyric: "Down", chord: "D"}]
    end
    
    it "keeps multiple spaces in a lyric" do
      ll = Music::LyricLine.new
      ll.lyricline = "Bad     Bad     Dog  "
      ll.chordline = "G               C"
      expect(ll.segments).to eq [{lyric: "Bad     Bad     ", chord: "G"},
                                 {lyric: "Dog  ", chord: "C"}]
    end

    it "inserts a lyric with no chord if lyric starts before first chord" do
      ll = Music::LyricLine.new
      ll.lyricline = "Good boy"
      ll.chordline = "     F#"
      expect(ll.segments).to eq [{lyric: "Good ", chord: nil},
                                 {lyric: "boy", chord: "F#"}]
      
    end
    
    it "inserts emtpy lyric if chord is between words" do
      ll = Music::LyricLine.new
      ll.lyricline = "Bad      Cat  "
      ll.chordline = "     G     "
      expect(ll.segments).to eq [{lyric: "Bad  ", chord: nil},
                                 {lyric: "    Cat  ", chord: "G"}]
    end

    it "has empty lyric when chord line is longer than lyric" do
      ll = Music::LyricLine.new
      ll.lyricline = "No one"
      ll.chordline = "       Dbmaj7"
      expect(ll.segments).to eq [{lyric: "No one ", chord: nil},
                                 {lyric: "      ", chord: "Dbmaj7"}]
    end

  end
end
