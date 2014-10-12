require 'feature_spec_helper'

# feature "Reading a chord sheet" do
  describe "the classic" do
    it "can filter out only the lyrics of a chord sheet" do
      raw_text = File.read(Music.root.join('spec', 'examples', 'chord_sheets', 'the_classic.txt'))
      chord_sheet = Music::ChordSheet.parse(raw_text)
      expect(chord_sheet.lyrics).to eq <<-EOT
The Classic - Joan as Policewoman

I am home in your arms and I feel like this is living
It’s been a lo---ng rocky road I have run

Could it be - that you're all, all I need to get by
And I love how it feels to be so high without sinnin'

It's been an a---lmighty drop into your heart
And it feels like I made it, made out with all I was hoping for

Could it be that you, you are the one? (x2)

And we blow through the air like we're floating on a feather
Rock and ro---ll is for sure here to stay

And this song we've been singing feels like it's always been sung
Do you know what that's called? Archetypal, you're the classic

Yes, you hummed me the tune that enraptured my heart
And you threw out all my devils to make room for monumental love

Could it be that you, you are the one? (x2)

No I never felt the sun warm my heart in the way you do
No I never felt the rain fill my tears with joy like you do
No I never felt the earth fluster the butterflies like you do
No I never felt anything like you

I am home in your arms and i feel like this is living
It's been a lo---ng rocky road I have run
And it feels like I made it made out with all I was hoping for

Could it be that you, you are the one? (x3)

See ya lay yes as I see ya lay yes as I see ya lay yes as I see you lay yes as I (x2)
EOT
    end
  end
# end
