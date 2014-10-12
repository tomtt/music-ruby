module Music
  module GlobalHelpers
    def reload!
      Music.load_all
    end
  end
end

extend Music::GlobalHelpers
