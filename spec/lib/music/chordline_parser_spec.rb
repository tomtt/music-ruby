require 'spec_helper'

describe Music::ChordlineParser do
  RSpec::Matchers.define :accept_chord do |chord|
    match do |parser|
      parsed_chord = parser.new(chord).chords.first
      !parsed_chord.nil? && parsed_chord[:name] == chord
    end
  end

  RSpec::Matchers.define :reject_chord do |chord|
    match do |parser|
      parsed_chord = parser.new(chord).chords.first
      parsed_chord.nil?
    end
  end

  describe "#chords" do

    it "is an empty list if there are non-chords in the line" do
      line = "Am a bed a bed"
      chords = Music::ChordlineParser.new(line).chords
      expect(chords).to be_empty
    end

    it "is the chord at its position if there is one" do
      line = "  Am"
      chords = Music::ChordlineParser.new(line).chords
      expect(chords.size).to eq 1
      chord = chords.first
      expect(chord[:position]).to eq 2
      expect(chord[:name]).to eq "Am"
    end

    it "handles multiple chords" do
      line = "D A Bm F#m G D G A"
      chords = Music::ChordlineParser.new(line).chords
      expect(chords.size).to eq 8
      expect(chords.map { |c| c[:position] }).to eq [0, 2, 4, 7, 11, 13, 15, 17]
      expect(chords.map { |c| c[:name] }).to eq ["D", "A", "Bm", "F#m", "G", "D", "G", "A"]
    end

    it "handles empty characters after last chord" do
      line = "  Am  "
      chords = Music::ChordlineParser.new(line).chords
      expect(chords.size).to eq 1
      chord = chords.first
      expect(chord[:position]).to eq 2
      expect(chord[:name]).to eq "Am"
    end
    
    describe "being passed a single chord" do
      subject { Music::ChordlineParser }
      
      it { is_expected.to accept_chord('A') }
      it { is_expected.to accept_chord('B') }
      it { is_expected.to accept_chord('C') }
      it { is_expected.to accept_chord('D') }
      it { is_expected.to accept_chord('E') }
      it { is_expected.to accept_chord('F') }
      it { is_expected.to accept_chord('G') }
      it { is_expected.to accept_chord('Gb') }
      it { is_expected.to accept_chord('G#') }
      it { is_expected.to accept_chord('D7') }
      
      it { is_expected.to reject_chord('a') }
      it { is_expected.to reject_chord('g') }
      it { is_expected.to reject_chord('H') }
      it { is_expected.to reject_chord('G#b') }
      it { is_expected.to reject_chord('Gb#') }
      it { is_expected.to reject_chord('D0') }
    end
  end
end
