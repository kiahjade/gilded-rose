require_relative 'item'

class GildedRose

  MAX_QUALITY = 50

  def initialize(items)
    @items = items
  end

  def update
    update_sell_in
    update_quality
  end

  def update_sell_in
    @items.each do |item|
      if item.name != "Sulfuras, Hand of Ragnaros"
        item.sell_in -= 1
      end
    end
  end

  def update_quality
    @items.each do |item|
      decrease_quality(item)
      decrease_quality(item) if sell_in_reached(item)
      if item.name == "Aged Brie"
        increase_quality(item)
        increase_quality(item) if sell_in_reached(item)
      end
      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        increase_faster(item)
        increase_quality(item) if item.sell_in < 11
        increase_quality(item) if item.sell_in < 6
        return item.quality = 0 if sell_in_reached(item)
      end
    end
  end

  private

  def conjured?(item)
    item.name == "Conjured"
  end

  def below_max_quality(item)
    item.quality < MAX_QUALITY
  end

  def increase_faster(item)
    item.quality += 2
  end

  def increase_quality(item)
    item.quality += 1 if below_max_quality(item)
  end

  def decrease_quality(item)
    if item.name != "Sulfuras, Hand of Ragnaros" && item.name != "Aged Brie"
      if item.quality > 0
        item.quality -= 1
        item.quality -= 1 if conjured?(item)
      end
    end
  end

  def sell_in_reached(item)
    item.sell_in < 0
  end
end
