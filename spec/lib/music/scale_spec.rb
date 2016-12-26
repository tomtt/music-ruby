require 'spec_helper'

describe Music::Scale do
  describe "creation" do
    it "raises an error if no mode is specified" do
      expect { Music::Scale.new({}) }.to raise_error(Music::Scale::UnknownModeError, "No mode specified")
    end

    it "raises an error if unknown mode is specified" do
      expect { Music::Scale.new(mode: :scoobydoo) }.to raise_error(Music::Scale::UnknownModeError, "Unknown mode: \"scoobydoo\"")
    end
  end

  describe "note_distances" do
    it "has the expected notes for the major scale" do
      expect(Music::Scale.new(mode: :major).note_distances).to eq [0, 2, 4, 5, 7, 9, 11]
    end

    it "has the expected notes for the minor pentatonic scale" do
      expect(Music::Scale.new(mode: :minor_pentatonic).note_distances).to eq [0, 3, 5, 7, 10]
    end

    it "has the expected notes for the blues scale" do
      expect(Music::Scale.new(mode: :blues).note_distances).to eq [0, 3, 5, 6, 7, 10]
    end

    it "has the expected notes for the natural minor scale" do
      expect(Music::Scale.new(mode: :natural_minor).note_distances).to eq [0, 2, 3, 5, 7, 8, 10]
    end

    it "has the expected notes for the harmonic minor scale" do
      expect(Music::Scale.new(mode: :harmonic_minor).note_distances).to eq [0, 2, 3, 5, 7, 8, 11]
    end

    it "has the expected notes for the melodic minor scale" do
      expect(Music::Scale.new(mode: :melodic_minor).note_distances).to eq [0, 2, 3, 5, 7, 9, 11]
    end
  end
end
