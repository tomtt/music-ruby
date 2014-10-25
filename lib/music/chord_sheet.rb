module Music
  class ChordSheet
    def self.parse(raw_text)
      new(raw_text)
    end

    def lyrics
      lines = @raw_text.split("\n")
      lyrics = []
      lines.each do |line|
        if line =~ /^[\s]*$/
          lyrics << :empty
        elsif ChordlineParser.new(line).chords.empty?
          lyrics << line.strip
        end
      end

      output = ""
      
      lyrics.each_with_index do |line, index|
        if line == :empty
          if lyrics[index - 1] == :empty || index == 0
            next
          else
            output << "\n"
          end
        else
          output << line.gsub(/[\s]+/, " ") + "\n"
        end
      end
      output
    end
    
    private

    def initialize(raw_text)
      @raw_text = raw_text
    end
  end
end
