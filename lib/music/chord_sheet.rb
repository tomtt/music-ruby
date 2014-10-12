module Music
  class ChordSheet
    def self.parse(raw_text)
      new(raw_text)
    end

    def lyrics
      @raw_text.split("\n").select { |l| l =~ /[h-ln-w]/i }.join("\n")
    end
    
    private

    def initialize(raw_text)
      @raw_text = raw_text
    end
  end
end
