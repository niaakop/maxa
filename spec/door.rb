require_relative '../door_class.rb'
require_relative 'spec_helper.rb'

describe Door do  
  before do 
    Door.clean_up    
  end

  it "should contain goat by default" do
    door = Door.new
    expect(door.item).to eq(:goat)
  end

  it "should contain 3 doors" do 
    expect(Door.seed_for_experiment.size).to eq(3)
  end

  it "should unlock" do 
    door = Door.new
    door.unlock
    expect(door.is_open).to eq(true)
  end

  it "change condition of 2 doors" do 
    door1 = Door.new
    door2 = Door.new
    Door.select(door1)
    expect(door1.is_selected).to eq(true)
    expect(door2.is_selected).to eq(false)
    Door.select(door2)
    expect(door2.is_selected).to eq(true)
    expect(door1.is_selected).to eq(false)
  end

  def infinite_seed_until_proof_randomnes
    loop do 
      Door.seed_for_experiment
      break if Door.find(2).item == :car
    end
    true
  end

  it "should be random" do 
    expect(infinite_seed_until_proof_randomnes).to eq(true)
  end
end
