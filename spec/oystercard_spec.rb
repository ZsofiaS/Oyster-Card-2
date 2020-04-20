require './lib/oystercard'

describe Oystercard do
  it "has a balance" do
    expect(subject).to respond_to(:balance)
  end

  it "tops up the card with a specified balance" do
    #card = Oystercard.new
    subject.top_up(10)
    expect(subject.balance).to eq 10

  end
end
