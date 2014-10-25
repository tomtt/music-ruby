require 'feature_spec_helper'

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

describe "bohemian rhapsody" do
  it "can filter out only the lyrics of a chord sheet" do
    raw_text = File.read(Music.root.join('spec', 'examples', 'chord_sheets', 'bohemian_rhapsody.txt'))
    chord_sheet = Music::ChordSheet.parse(raw_text)
    expect(chord_sheet.lyrics).to eq <<-EOT
Intro:
(slowly)
Is this the real life? Is this just fantasy?

Caught in a land - slide, no escape from re - ality.

Open your eyes, look up to the skies and see.

I'm just a poor boy, I need no sympathy, because I'm

easy come, easy go, little high, little low.

Anyway the wind blows doesn't really matter to me, to_____ me.

Verse:

Mama_____ just killed a man, put a gun against his head,

pulled my trigger, now he's dead.

Mama,____ life had just begun, but now I've gone and

thrown it all a - way.

Mama, ooh__________ didn't mean to make you cry.

If I'm not back again this time tomorrow, car - ry on, car - ry on

as if nothing really matters.____

Verse 2:

Too late,_____ my time has come, sends shivers down my spine,
body's aching all the time.
Goodbye, everybody, I've got to go, gotta leave you all
behind and face the truth.
Mama, ooh_____ I don't want to die,

I sometimes wish I'd never been born at all.

Verse 3:
(faster)
I see a lit - tle sil - hou - et - to of a man.

Scar - a - mouche, Scar - a - mouche, will you do the Fan - dan - go?

Thunderbolt and lightning very, very fright'ning me.

Gallileo, Gallileo, Gallileo, Figaro, Magnifico.__________

I'm just a poor boy and no - bod - y loves me.

He's just a poor boy from a poor fam - i - ly.

Spare him his life from this mon - stros - i - ty.

Easy come, easy go, will you let me go? Bis - mil - lah!

No, we will not let you go. Bismillah!

We will not let you go. Bismillah! We will not let you go.

Will not let you go. Will not let you go.

Ahhhhhhhhh________________________________

No, no, no, no, no, no, no.

Mama mia, let me go. Be - el - ze - bub has a devil put aside for me,

for me,______ for me.______

So you think you can stone me and spit in my eye.______

So you think you can love me and leave me to die.______

Oh,______ baby,______ can't do this to me, baby.______

Just gotta get out, just gotta get right outta here.______

(slowly, a tempo)

Nothing really matters, anyone can see.

Nothing really matters, nothing really matters to me.______

Any - way the wind blows.

End on F
EOT
  end
end
