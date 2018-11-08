class GildedRose

MIN_QUALITY = 0
MAX_QUALITY = 50
SULFURAS = 80

  def initialize(items)
    @items = items
    @special_items = [
      "Aged Brie",
      "Backstage passes to a TAFKAL80ETC concert",
      "Sulfuras, Hand of Ragnaros",
      "Conjured"
    ]
  end

  def updated_quality(item, int)
    item.quality += int
    if item.quality > MAX_QUALITY
      excess = item.quality - MAX_QUALITY
      item.quality -= excess
    end
    item.quality
  end

  def update_aged_brie(item)
    if item.sell_in <= 0
      item.quality = updated_quality(item, 2)
    else item.sell_in > 0
      item.quality = updated_quality(item, 1)
    end
  end

  def sulfuras
    item.quality = SULFURAS
  end

  def update_backstage_pass(item)
    if item.sell_in <= 0
      item.quality = MIN_QUALITY
    elsif item.sell_in <= 5
      item.quality = updated_quality(item, 3)
    elsif item.sell_in <= 10
      item.quality = updated_quality(item, 2)
    elsif item.sell_in > 10
      item.quality = updated_quality(item, 1)
    end
  end

  def conjoured_item(item)
    if item.quality > MIN_QUALITY && item.sell_in < 0
      item.quality = item.quality - 4
    elsif item.quality > MIN_QUALITY
      item.quality = item.quality - 2
    end
  end


  def update_quality

    @items.each do |item|

      if !@special_items.include?(item.name)
          item.sell_in = item.sell_in - 1
      end

      if item.name == "Sulfuras, Hand of Ragnaros"
        item.quality = SULFURAS
      end

      if item.name == "Backstage passes to a TAFKAL80ETC concert"
        return update_backstage_pass(item)
      end

      if item.name == "Aged Brie"
        return update_aged_brie(item)
      end

      if item.name == "Conjured"
        return conjured_item(item)
      end

      if !@special_items.include?(item.name)
        if item.quality > MIN_QUALITY && item.sell_in < 0
          item.quality = item.quality - 2
        elsif item.quality > MIN_QUALITY
          item.quality = item.quality - 1
        end
      end
    end
  end
end
