describe Music::ChordSheet do
  describe ".parse" do
    subject { Music::ChordSheet.parse(raw_text) }
    context "for a single line of lyrics with chords" do
      let(:raw_text) { <<-EOT }
C
Row row row your boat gently down the stream. Merrily merrily merrily merrily life is but a dream.
EOT
      it "can parse out just the lyrics" do
        expected_lyrics = "Row row row your boat gently down the stream. Merrily merrily merrily merrily life is but a dream."
        expect(subject.lyrics).to eq expected_lyrics
      end
    end
  end
end
