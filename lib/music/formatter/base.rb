module Music
  module Formatter
    class Base
      def initialize(chord_sheet)
        @chord_sheet = chord_sheet
      end

      def render
        raise "Not implemented"
      end
    end
  end
end
