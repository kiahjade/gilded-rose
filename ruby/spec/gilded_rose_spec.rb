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

    it "item quality is never higher than 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 50
    end

    it "decreases quality twice as much after sell by reached" do
      items =[Item.new("toast", 0, 4)]
      GildedRose.new(items).update_quality
      expect(items[0].quality).to eq 2
    end
  end

end
