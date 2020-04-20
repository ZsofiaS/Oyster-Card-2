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
  end

  it "deducts specified amount of money from the card" do
    subject.top_up(50)
    subject.deduct(5)
    expect(subject.balance).to eq 45
  end

  it "checks that it can be touched in" do
    expect(subject).to respond_to(:touch_in)
  end

  it "checks if a card can show if it's in_journey?" do
    expect(subject).to respond_to(:in_journey)
  end

  it "checks if in_journey is true if card is touched in" do
    subject.touch_in
    expect(subject.in_journey).to eq true
  end

end
