require './lib/oystercard'

describe Oystercard do
  limit = Oystercard::LIMIT


  it "has a balance" do
    expect(subject).to respond_to(:balance)
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
    subject.touch_out
    expect(subject.balance).to eq 49
  end

  it "checks that it can be touched in" do
    expect(subject).to respond_to(:touch_in).with(1).argument
  end

  it "checks if a card can show if it's in_journey?" do
    expect(subject).to respond_to(:in_journey)
  end

  it "checks if in_journey is true if card is touched in" do
  station = double("Station", :name => "Camden")
    subject.top_up(2)
    subject.touch_in(station)
    expect(subject.in_journey).to eq true
  end

  it "checks if in_journey is false if card is touched out" do
      station = double("Station", :name => "Camden")
    subject.top_up(2)
    subject.touch_in(station)
    subject.touch_out
    expect(subject.in_journey).to be_falsey
  end

  describe "#touch_out" do
    it "deducts correct amount for journey" do
        station = double("Station", :name => "Camden")
      subject.top_up(10)
      subject.touch_in(station)
      expect { subject.touch_out }.to change{subject.balance}.by(-1)
    end
  end

  it "remebers station when touched in" do
    subject.top_up(10)
    station = double("Station", :name => "Camden")
    subject.touch_in(station)
    expect(subject.entry_station.name).to eq("Camden")
  end
end
