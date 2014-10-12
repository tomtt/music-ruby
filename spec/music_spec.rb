require 'spec_helper'

describe Music do
  it "knows its root" do
    expect(Music.root).to eq Pathname.new(File.absolute_path("."))
  end
end
