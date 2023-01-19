class Door
  POSSIBLE_ITEMS = { default: :goat, win: :car }
  attr_reader :item, :is_open
  attr_accessor :is_selected, :position
  @@all = []

  def initialize(item = POSSIBLE_ITEMS[:default])
    @item = item
    @is_open = false
    @is_selected = false
    @@all << self 
    @position = @@all.size - 1
  end

  def self.seed_for_experiment
    2.times do
      new
    end 
    new(POSSIBLE_ITEMS[:win])
    @@all = @@all.shuffle
    @@all.map { |d| d.position = @@all.index(d) }
  end
      
  def self.find(n = nil)
    return @@all.shuffle.find { |d| d.position == n } unless n.nil?
    @@all.shuffle.find { |d| yield(d) }
  end

  def self.select(d)
    find_selected.is_selected = false unless find_selected.nil? 
    d.is_selected = true
  end

  def self.find_selected
    find { |d| d.is_selected }
  end

  def self.clean_up
    @@all.clear
  end

  def unlock
    puts "Behind Door #{@position+1} is a #{item}."
    @is_open = true
  end
end
