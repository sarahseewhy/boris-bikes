require_relative'../lib/bike_container.rb'

class ContainerHolder; include BikeContainer; end

describe BikeContainer do
  
  let(:bike) { Bike.new }
  let(:holder) { ContainerHolder.new }

  def fill_holder(holder)
    holder.capacity.times { holder.dock(Bike.new) }
  end

  it "accepts a bike" do        
    expect(holder.bike_count).to eq(0)
    holder.dock(bike)    
    expect(holder.bike_count).to eq(1)
  end

  it "releases a bike" do
    holder.dock(bike)
    holder.release(bike)
    expect(holder.bike_count).to eq(0)
  end

  it "knows when it's full" do
    expect(holder).not_to be_full
    fill_holder(holder)
    expect(holder).to be_full
  end

  it "knows when it's empty" do
    expect(holder).to be_empty
  end

  it "does not release a bike if it's empty" do
    expect{ holder.empty_holder(bike) }.to raise_error(RuntimeError)
  end

  it "does not accept a bike if it's full" do
    fill_holder(holder)
    expect{ holder.dock(bike) }.to raise_error(RuntimeError)
  end

  it "provides the list of available bikes" do
    working_bike, broken_bike = Bike.new, Bike.new    
    broken_bike.break
    holder.dock(working_bike)
    holder.dock(broken_bike)
    expect(holder.available_bikes).to eq([working_bike])
  end
end