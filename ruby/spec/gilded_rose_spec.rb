require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end

    it "decreases quality of item" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 9
    end

    it "cannot have a negative quality" do
      items = [Item.new("foo", 10, 0)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 0
    end
  end

end
