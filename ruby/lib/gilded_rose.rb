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
      if conjured?(item)
        decrease_faster(item)
      end

      if !special_item?(item)
        not_sulfuras(item)
      else
        increase_quality(item)
        if item.name == "Backstage passes to a TAFKAL80ETC concert"
          if item.sell_in < 11
            increase_quality(item)
          end
          if item.sell_in < 6
            increase_quality(item)
          end
        end
      end
      if sell_in_reached(item)
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

  def below_max_quality(item)
    item.quality < MAX_QUALITY
  end

  def decrease_faster(item)
    item.quality -= 2
  end

  def increase_quality(item)
    item.quality += 1 if below_max_quality(item)
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

  def sell_in_reached(item)
    item.sell_in < 0
  end
end
