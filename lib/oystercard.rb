class Oystercard
  LIMIT = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance, :entry_station
  attr_accessor :in_journey

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
    @entry_station = nil
  end

  def top_up(amount)
    @balance + amount <= LIMIT ? @balance += amount : exceeds_balance
  end

  def touch_in(station)
    raise "Does not have the minimum amount" if @balance < MINIMUM_BALANCE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    @in_journey = false
    deduct(MINIMUM_BALANCE)
  end

  private
  def exceeds_balance
    raise "Exceeds balance limit of #{LIMIT}"
  end

  def deduct(amount)
    @balance -= amount
  end

end
