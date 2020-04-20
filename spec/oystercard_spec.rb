require './lib/oystercard'

describe Oystercard do
  it "has a balance" do
    expect(subject).to respond_to(:balance)
  end
end
