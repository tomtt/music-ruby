require 'spec_helper'

require 'music/note'

describe Music::Note do
  describe "creation" do
    it "raises an error if name is not a note name" do
      expect { Music::Note.new("X", 4) }.to raise_error(Music::Note::InvalidNoteError, "Unknown note: \"X\"")
    end
  end

  describe "<=>" do
    it "orders E5 after E4" do
      expect(Music::Note.new("E", 5) > Music::Note.new("E", 4)).to be_truthy
    end

    it "orders E5 before E6" do
      expect(Music::Note.new("E", 5) < Music::Note.new("E", 6)).to be_truthy
    end

    it "orders D4 before E4" do
      expect(Music::Note.new("D", 4) < Music::Note.new("E", 4)).to be_truthy
    end

    it "orders C4 before A4" do
      expect(Music::Note.new("C", 4) < Music::Note.new("A", 4)).to be_truthy
    end

    it "orders identical notes to be identical independent of accidental" do
      expect(Music::Note.new("Gb", 5)).to eq Music::Note.new("F#", 5)
    end

    it "orders notes in the correct order" do
      expected_order = [ Music::Note.new("B", 2),
                         Music::Note.new("C", 3),
                         Music::Note.new("D", 3),
                         Music::Note.new("E", 3),
                         Music::Note.new("F", 3),
                         Music::Note.new("G", 3),
                         Music::Note.new("A", 3),
                         Music::Note.new("B", 3),
                         Music::Note.new("C", 4)
                       ]
      expect(expected_order.sort.map(&:full_name)).to eq expected_order.map(&:full_name)
    end
  end
  
  describe "full_name" do
    it "is C4 for note with name C, octave 4" do
      expect(Music::Note.new("C", 4).full_name).to eq "C4"
    end

    it "is C#4 for note with name C#, octave 4" do
      expect(Music::Note.new("C#", 4).full_name).to eq "C#4"
    end

    it "is Db4 for note with name Db, octave 4" do
      expect(Music::Note.new("Db", 4).full_name).to eq "Db4"
    end

    it "raises an error when accidental is invalid" do
      expect { Music::Note.new("D", 4).full_name(:derp) }.to raise_error(Music::Note::InvalidAccidentalError, "Unknown accidental: derp")
    end
    
    it "accepts a string for the accidental" do
      expect(Music::Note.new("Eb", 4).full_name("sharp")).to eq "D#4"
    end
    
    it "has the following results for default accidental" do
      [
       ["A",  2, "A2"],
       ["A#", 2, "A#2"],
       ["Bb", 2, "Bb2"],
       ["C",  2, "C2"],
       ["C#", 2, "C#2"],
       ["Db", 2, "Db2"],
       ["D",  2, "D2"],
       ["D#", 2, "D#2"],
       ["Eb", 2, "Eb2"],
       ["E",  2, "E2"],
       ["F",  2, "F2"],
       ["F#", 2, "F#2"],
       ["Gb", 2, "Gb2"],
       ["G",  2, "G2"],
       ["G#", 2, "G#2"],
       ["Ab", 2, "Ab2"],
       ["A",  3, "A3"]
      ].each do |name, octave, expected_full_name|
        expect(Music::Note.new(name, octave).full_name).to eq expected_full_name
      end
    end
    
    it "has the following results for sharp accidental" do
      [
       ["A",  2, "A2"],
       ["A#", 2, "A#2"],
       ["Bb", 2, "A#2"],
       ["C",  2, "C2"],
       ["C#", 2, "C#2"],
       ["Db", 2, "C#2"],
       ["D",  2, "D2"],
       ["D#", 2, "D#2"],
       ["Eb", 2, "D#2"],
       ["E",  2, "E2"],
       ["F",  2, "F2"],
       ["F#", 2, "F#2"],
       ["Gb", 2, "F#2"],
       ["G",  2, "G2"],
       ["G#", 2, "G#2"],
       ["Ab", 2, "G#2"],
       ["A",  3, "A3"]
      ].each do |name, octave, expected_full_name|
        expect(Music::Note.new(name, octave).full_name(:sharp)).to eq expected_full_name
      end
    end

    it "has the following results for flat accidental" do
      [
       ["A",  2, "A2"],
       ["A#", 2, "Bb2"],
       ["Bb", 2, "Bb2"],
       ["C",  2, "C2"],
       ["C#", 2, "Db2"],
       ["Db", 2, "Db2"],
       ["D",  2, "D2"],
       ["D#", 2, "Eb2"],
       ["Eb", 2, "Eb2"],
       ["E",  2, "E2"],
       ["F",  2, "F2"],
       ["F#", 2, "Gb2"],
       ["Gb", 2, "Gb2"],
       ["G",  2, "G2"],
       ["G#", 2, "Ab2"],
       ["Ab", 2, "Ab2"],
       ["A",  3, "A3"]
      ].each do |name, octave, expected_full_name|
        expect(Music::Note.new(name, octave).full_name(:flat)).to eq expected_full_name
      end
    end
  end
end
