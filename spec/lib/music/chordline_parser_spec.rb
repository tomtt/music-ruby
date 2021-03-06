require 'spec_helper'

describe Music::ChordlineParser do
  RSpec::Matchers.define :accept_chord do |chord|
    parsed_chord = nil

    match do |parser|
      parsed_chord = parser.new(chord).chords.first
      !parsed_chord.nil? && parsed_chord[:name] == chord
    end

    failure_message do
      if parsed_chord.nil?
        "expected Music::ChordlineParser to accept chord \"#{chord}\, no chord found"
      else
        "expected Music::ChordlineParser to accept chord \"#{chord}\, found #{parsed_chord[:name]} instead"
      end
    end
  end

  RSpec::Matchers.define :reject_chord do |chord|
    parsed_chord = nil

    match do |parser|
      parsed_chord = parser.new(chord).chords.first
      parsed_chord.nil?
    end

    failure_message do
      "expected Music::ChordlineParser to accept chord \"#{chord}\, but found #{parsed_chord[:name]}"
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

    it "handles complex chords appear after each other without a whitespace seperation" do
      line = " C#7Ab5"
      chords = Music::ChordlineParser.new(line).chords
      expect(chords.size).to eq 2
      expect(chords.map { |c| c[:position] }).to eq [1, 4]
      expect(chords.map { |c| c[:name] }).to eq ["C#7", "Ab5"]
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
      it { is_expected.to accept_chord('Bb6') }
      it { is_expected.to accept_chord('F#m') }
      it { is_expected.to accept_chord('C/G') }
      it { is_expected.to accept_chord('Cm/G') }
      it { is_expected.to accept_chord('Bb(Dbass)') }
      it { is_expected.to accept_chord('D0') }
      it { is_expected.to accept_chord('C#o') }
      it { is_expected.to accept_chord('C#dim') }
      it { is_expected.to accept_chord('Eb/Bb') }
      it { is_expected.to accept_chord('B+') }
      it { is_expected.to accept_chord('Baug') }
      it { is_expected.to accept_chord('C7-9') }
      it { is_expected.to accept_chord('Bb11') }
      it { is_expected.to accept_chord('Amaj7') }
      it { is_expected.to accept_chord('Emajor') }
      it { is_expected.to accept_chord('Eminor') }
      it { is_expected.to accept_chord('Emin') }
      it { is_expected.to accept_chord('Gbo7') }
      it { is_expected.to accept_chord('Gbdim7') }
      it { is_expected.to accept_chord('C#7b5') }
      it { is_expected.to accept_chord('Emin') }
      it { is_expected.to accept_chord('Esus2') }
      it { is_expected.to accept_chord('Esus4') }
      it { is_expected.to accept_chord('E7sus2') }
      it { is_expected.to accept_chord('E7sus4') }
      it { is_expected.to accept_chord('F#m7') }

      it { is_expected.to accept_chord('no chords') }
      it { is_expected.to accept_chord('No Chords') }
      it { is_expected.to accept_chord('No chords') }
      it { is_expected.to accept_chord('N/C') }
      it { is_expected.to accept_chord('n/c') }
      it { is_expected.to accept_chord('nc') }
      it { is_expected.to accept_chord('n.c.') }
      it { is_expected.to accept_chord('NC') }
      it { is_expected.to accept_chord('N.C.') }
      it { is_expected.to accept_chord('D(X)') }
      it { is_expected.to accept_chord('D(10th fret)') }

      it { is_expected.to reject_chord('a') }
      it { is_expected.to reject_chord('g') }
      it { is_expected.to reject_chord('H') }
      it { is_expected.to reject_chord('G#b') }
      it { is_expected.to reject_chord('Gb#') }
      it { is_expected.to reject_chord('Fm#') }
      it { is_expected.to reject_chord('C/g') }
      it { is_expected.to reject_chord('C/Gm') }
    end
  end
end
