class Tile
  def initialize(value, visibility = false)
    @visiblity = visbility
    @value = value

  end

  def is_bomb?
    @value == "b"
  end

  def is_empty?
    @value == 0
  end

  def to_s
    if @visibility
      if is_bomb?
        "b"
      elsif is_empty?
        "0"
      else
        @value.to_s
      end
    else
      "_"
    end
  end

  def reveal
    @visiblity = true
  end
  
end
