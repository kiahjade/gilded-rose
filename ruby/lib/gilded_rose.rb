require_relative 'item'

class GildedRose

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
      if conjured?(item)
        decrease_faster(item)
      end

      if !special_item?(item)
        not_sulfuras(item)
      else
        if item.quality < 50
          item.quality = item.quality + 1
          if item.name == "Backstage passes to a TAFKAL80ETC concert"
            if item.sell_in < 11
              increase_quality(item)
            end
            if item.sell_in < 6
              increase_quality(item)
            end
          end
        end
      end
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              not_sulfuras(item)
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          increase_quality(item)
        end
      end
    end
  end

  private

  def special_item?(item)
    item.name == "Aged Brie" || item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def conjured?(item)
    item.name == "Conjured"
  end

  def decrease_faster(item)
    item.quality -= 2
  end

  def increase_quality(item)
    item.quality < 50
    item.quality += 1
  end

  def decrease_quality(item)
    item.quality -= 1
  end

  def not_sulfuras(item)
    if item.quality > 0
      if item.name != "Sulfuras, Hand of Ragnaros"
        decrease_quality(item)
      end
    end
  end
end
