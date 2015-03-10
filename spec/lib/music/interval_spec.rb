require 'spec_helper'

describe Music::Interval do
  describe ".between_notes" do
    let(:interval) { Music::Interval.between_notes(note1, note2) }
    subject { interval }

    it "matches these examples in relation to F#5" do
      examples = [["E",  4, -14, :major_ninth,    :descending],
                  ["F",  4, -13, :minor_ninth,    :descending],
                  ["F#", 4, -12, :octave,         :descending],
                  ["G",  4, -11, :major_seventh,  :descending],
                  ["G#", 4, -10, :minor_seventh,  :descending],
                  ["A",  4,  -9, :major_sixth,    :descending],
                  ["A#", 4,  -8, :minor_sixth,    :descending],
                  ["B",  4,  -7, :perfect_fifth,  :descending],
                  ["C",  5,  -6, :tritone,        :descending],
                  ["C#", 5,  -5, :perfect_fourth, :descending],
                  ["D",  5,  -4, :major_third,    :descending],
                  ["D#", 5,  -3, :minor_third,    :descending],
                  ["E",  5,  -2, :major_second,   :descending],
                  ["F",  5,  -1, :minor_second,   :descending],
                  ["F#", 5,   0, :unison,         :unison],
                  ["G",  5,   1, :minor_second,   :ascending],
                  ["G#", 5,   2, :major_second,   :ascending],
                  ["A",  5,   3, :minor_third,    :ascending],
                  ["A#", 5,   4, :major_third,    :ascending],
                  ["B",  5,   5, :perfect_fourth, :ascending],
                  ["C",  6,   6, :tritone,        :ascending],
                  ["C#", 6,   7, :perfect_fifth,  :ascending],
                  ["D",  6,   8, :minor_sixth,    :ascending],
                  ["D#", 6,   9, :major_sixth,    :ascending],
                  ["E",  6,  10, :minor_seventh,  :ascending],
                  ["F",  6,  11, :major_seventh,  :ascending],
                  ["F#", 6,  12, :octave,         :ascending],
                  ["G",  6,  13, :minor_ninth,    :ascending],
                  ["G#", 6,  14, :major_ninth,    :ascending]]

      from_note = Music::Note.new("F#", 5)
      
      examples.each do |name, octave, expected_distance, expected_type, expected_direction|
        to_note = Music::Note.new(name, octave)
        interval = Music::Interval.between_notes(from_note, to_note)
        expect(interval.distance).to eq expected_distance
        expect(interval.type).to eq expected_type
        expect(interval.direction).to eq expected_direction
      end
    end
    
    context "for identical notes" do
      let(:note1) { Music::Note.new("F#", 5) }
      let(:note2) { Music::Note.new("F#", 5) }

      its(:distance) { should == 0 }
      its(:type) { should == :unison }
      its(:direction) { should == :unison }
    end

    context "for notes 1 semitone apart, ascending" do
      let(:note1) { Music::Note.new("F#", 5) }
      let(:note2) { Music::Note.new("G", 5) }

      its(:distance) { should == 1 }
      its(:type) { should == :minor_second }
      its(:direction) { should == :ascending }
    end

    context "for notes 1 semitone apart, descending" do
      let(:note1) { Music::Note.new("G", 5) }
      let(:note2) { Music::Note.new("F#", 5) }

      its(:distance) { should == -1 }
      its(:type) { should == :minor_second }
      its(:direction) { should == :descending }
    end

    context "for notes 1 octave apart, ascending" do
      let(:note1) { Music::Note.new("Bb", 4) }
      let(:note2) { Music::Note.new("Bb", 5) }

      its(:distance) { should == 12 }
      its(:type) { should == :octave }
      its(:direction) { should == :ascending }
    end

  end
end
