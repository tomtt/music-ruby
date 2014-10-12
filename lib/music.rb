require 'pathname'

module Music
  def self.root
    Pathname.new(File.absolute_path(File.join(File.dirname(__FILE__), '..')))
  end

  def self.require_all
    with_ruby_files { |file| require file}
  end

  def self.load_all
    with_ruby_files do |file|
      puts "loading #{file}"
      load file
    end
  end

  def self.with_ruby_files(&block)
    Dir.glob(File.join(Music.root, 'lib', 'music', '**', "*.rb")) { |file| yield(file) }
    Dir.glob(File.join(Music.root, 'config', '**', "*.rb")) { |file| yield(file) }
  end
end

Music.require_all
