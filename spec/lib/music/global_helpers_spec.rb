require 'spec_helper'
require 'music/global_helpers'

describe Music::GlobalHelpers do
  def irb_context
    Object.new.extend(Music::GlobalHelpers)
  end
  
  it "defines a :reload! top level method that calls Music::load_all" do
    expect(Music).to receive(:load_all)
    irb_context.reload!
  end
end
