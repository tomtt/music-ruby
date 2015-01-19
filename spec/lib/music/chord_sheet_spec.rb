require 'spec_helper'

describe Music::ChordSheet do
  describe ".parse" do
    subject { Music::ChordSheet.parse(raw_text) }
    context "for a single line of lyrics with chords" do
      let(:raw_text) { <<-EOT }
C
Row row row your boat gently down the stream. Merrily merrily merrily merrily life is but a dream.
EOT
      it "can parse out just the lyrics" do
        expected_lyrics = "Row row row your boat gently down the stream. Merrily merrily merrily merrily life is but a dream.\n"
        expect(subject.lyrics).to eq expected_lyrics
      end
    end

    context "for multiple lines where lyrics only contain chord characters" do
      let(:raw_text) { <<-EOT }
G             C
  Am a bed a bed



D        D7 G
Fa fa fa a  bed!
EOT

      it "has an empty line in the lyrics, ignoring trailing whitespace" do
        expected_lyrics = <<-EOT
Am a bed a bed

Fa fa fa a bed!
EOT
        expect(subject.lyrics).to eq expected_lyrics
      end
    end
  end

  describe ".lines" do
    it "is an empty list if there are no lines" do
      expect(Music::ChordSheet.parse("").lines).to be_empty
    end
  end
end
