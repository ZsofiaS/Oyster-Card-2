require './lib/oystercard'

describe Oystercard do
  limit = Oystercard::LIMIT

  it "has a balance" do
    expect(subject).to respond_to(:balance)
  end

  it "can store journeys" do
    station = double("Station", :name => "Camden")
    exit_station = double("Station", :name => "Angel")
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.journeys["entry_station"].count).to eq 1
  end

  it "has no journeys stored" do
    expect(subject.journeys["entry_station"].count).to eq 0
    expect(subject.journeys["exit_station"].count).to eq 0
  end

  it "stores a journey when touched in and touched out" do
    station = double("Station", :name => "Camden")
    exit_station = double("Station", :name => "Angel")
    subject.top_up(10)
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.journeys["entry_station"][0].name).to eq "Camden"
    expect(subject.journeys["exit_station"][0].name).to eq "Angel"
  end

  describe "top_up method" do
    it "tops up the card with a specified balance" do
      subject.top_up(10)
      expect(subject.balance).to eq 10
    end

    it "returns exceed limit error if top_up exceeds balance limit of #{limit}" do
      subject.top_up(50)
      expect { subject.top_up(50) }.to raise_error("Exceeds balance limit of #{limit}")
    end

    it "returns error when touching in if balance is less than minimum amount" do
      station = double("Station", :name => "Camden")
      subject.top_up(0.5)
      expect { subject.touch_in(station) }.to raise_error("Does not have the minimum amount")
    end
  end

  it "deducts specified amount of money from the card" do
    subject.top_up(50)
    station = double("Station", :name => "Camden")
    exit_station = double("Station", :name => "Angel")
    subject.touch_in(station)
    subject.touch_out(exit_station)
    expect(subject.balance).to eq 49
  end

  it "checks that it can be touched in" do
    expect(subject).to respond_to(:touch_in).with(1).argument
  end

  describe "#touch_out" do
    it "deducts correct amount for journey" do
        station = double("Station", :name => "Camden")
        exit_station = double("Station", :name => "Angel")
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out(exit_station) }.to change{subject.balance}.by(-1)
    end
  end

  it "remebers station when touched in" do
    subject.top_up(10)
    station = double("Station", :name => "Camden")
    subject.touch_in(station)
    expect(subject.entry_station.name).to eq("Camden")
  end

  it "forgets station when touched out" do
    subject.top_up(10)
    station = double("Station", :name => "Camden")
    exit_station = double("Station", :name => "Angel")
    subject.touch_in(station)
    expect { subject.touch_out(exit_station) }.to change{subject.entry_station}.to(nil)
  end
end
