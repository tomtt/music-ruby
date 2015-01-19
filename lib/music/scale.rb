module Music
  class Scale

    class UnknownModeError < StandardError; end

    SCALE_MAPPINGS = {
      major: :ionian,
      harmonic_minor: :aeolian
    }

    SCALE_MODES = {
      minor_pentatonic: [0, 3, 5, 7, 10],
      blues:            [0, 3, 5, 6, 7, 10],
      ionian:           [0, 2, 4, 5, 7, 9, 11], # wwhwwwh
      dorian:           [0, 2, 3, 5, 7, 9, 10], # whwwwhw
      phrygian:         [0, 1, 3, 5, 7, 8, 10], # hwwwhww
      lydian:           [0, 2, 4, 6, 7, 9, 11], # wwwhwwh
      mixolydian:       [0, 2, 4, 5, 7, 9, 10], # wwhwwhw
      aeolian:          [0, 2, 3, 5, 7, 8, 10], # whwwhww
      locrian:          [0, 1, 3, 5, 6, 8, 10]  # hwwhwww
    }

    def initialize(args)
      @mode = args.delete(:mode)
      raise UnknownModeError, "No mode specified" if @mode.blank?
      @effective_mode = SCALE_MAPPINGS[@mode] || @mode
      raise UnknownModeError, "Unknown mode: \"#{@mode}\"" unless SCALE_MODES.has_key?(@effective_mode)
    end

    def note_distances
      SCALE_MODES[@effective_mode]
    end
  end
end
