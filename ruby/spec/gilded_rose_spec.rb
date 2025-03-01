require 'gilded_rose'

describe GildedRose do

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update
      expect(items[0].name).to eq "foo"
    end

    it "decreases quality of item" do
      items = [Item.new("foo", 10, 10)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 9
    end

    it "cannot have a negative quality" do
      items = [Item.new("foo", 10, 0)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end

    it "item quality is never higher than 50" do
      items = [Item.new("Aged Brie", 10, 50)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 50
    end

    it "decreases quality twice as much after sell by reached" do
      items =[Item.new("toast", 0, 4)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 2
    end

    it "cannot sell or decrease quality of sulfuras" do
      items =[Item.new("Sulfuras, Hand of Ragnaros", 10, 10)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 10
      expect(items[0].sell_in).to eq 10
    end

    it "increases quality of backstage passes as sell in value decreases" do
      items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 5, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 8
      items =[Item.new("Backstage passes to a TAFKAL80ETC concert", 10, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 7
      items =[Item.new("Backstage passes to a TAFKAL80ETC concert", -1, 2)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 0
    end

    it "decreases sell in value twice as fast for conjured items" do
      items =[Item.new("Conjured", 5, 5)]
      GildedRose.new(items).update
      expect(items[0].quality).to eq 3
    end
  end

end
