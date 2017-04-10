require 'spec_helper'

describe Music::LyricLine do
  describe ".segments" do
    it "raises when lyric line is assigned before chordline" do
      expect(-> do
               ll = Music::LyricLine.new
               ll.lyricline = "Random words"
               ll.chordline = "G      D    "
      end).to raise_error
    end

    it "has only one segment for a lyric with no chords" do
      ll = Music::LyricLine.new
      ll.lyricline = "Some lyric"
      expect(ll.segments).to eq [{lyric: "Some lyric", chord: nil}]
    end

    it "has a segment for each chord" do
      ll = Music::LyricLine.new
      ll.chordline = "G      D    "
      ll.lyricline = "Random words"
      expect(ll.segments).to eq [{lyric: "Random ", chord: "G"}, {lyric: "words", chord: "D"}]
    end

    it "has a segment without lyrics for chords before line" do
      ll = Music::LyricLine.new
      ll.chordline = "G      C    D   "
      ll.lyricline = "       Fall Down"
      expect(ll.segments).to eq [{lyric: "       ", chord: "G"},
                                 {lyric: "Fall ", chord: "C"},
                                 {lyric: "Down", chord: "D"}]
    end

    it "keeps multiple spaces in a lyric" do
      ll = Music::LyricLine.new
      ll.chordline = "G               C"
      ll.lyricline = "Bad     Bad     Dog  "
      expect(ll.segments).to eq [{lyric: "Bad     Bad     ", chord: "G"},
                                 {lyric: "Dog  ", chord: "C"}]
    end

    it "inserts a lyric with no chord if lyric starts before first chord" do
      ll = Music::LyricLine.new
      ll.chordline = "     F#"
      ll.lyricline = "Good boy"
      expect(ll.segments).to eq [{lyric: "Good ", chord: nil},
                                 {lyric: "boy", chord: "F#"}]

    end

    it "inserts emtpy lyric if chord is between words" do
      ll = Music::LyricLine.new
      ll.chordline = "     G     "
      ll.lyricline = "Bad      Cat  "
      expect(ll.segments).to eq [{lyric: "Bad  ", chord: nil},
                                 {lyric: "    ", chord: "G"},
                                 {lyric: "Cat  ", chord: nil}]
    end

    it "does not split in a new segment if lyrics and chord start at the beginning" do
      ll = Music::LyricLine.new
      ll.chordline = "Bm      A         G A    Bm"
      ll.lyricline = "Om namo Bhagavate Vasude vaya x2"
      expect(ll.segments).to eq [{lyric: "Om namo ", chord: "Bm"},
                                 {lyric: "Bhagavate ", chord: "A"},
                                 {lyric: "Va", chord: "G"},
                                 {lyric: "sude ", chord: "A"},
                                 {lyric: "vaya x2", chord: "Bm"}
                               ]
    end

    it "has empty lyric when chord line is longer than lyric" do
      ll = Music::LyricLine.new
      ll.chordline = "       Dbmaj7"
      ll.lyricline = "No one"
      expect(ll.segments).to eq [{lyric: "No one ", chord: nil},
                                 {lyric: "      ", chord: "Dbmaj7"}]
    end

    it "has empty lyrics if there is just a chord line" do
      ll = Music::LyricLine.new
      ll.chordline = "Dbmaj7"
      expect(ll.segments).to eq [{lyric: "      ", chord: "Dbmaj7"}]
    end
  end
end
