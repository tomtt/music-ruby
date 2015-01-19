require Music.root.join 'config/initializers/object'

describe Object do
  describe "blank?" do
    it "is truthy for nil" do
      expect(nil.blank?).to be_truthy
    end
    
    it "is falsey for empty array" do
      expect([].blank?).to be_falsey
    end

    it "is truthy for empty string" do
      expect("   ".blank?).to be_truthy
    end
    
    it "is falsey for string with characters" do
      expect("f".blank?).to be_falsey
    end
  end
end
