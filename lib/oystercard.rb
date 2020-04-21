class Oystercard
  LIMIT = 90
  MINIMUM_BALANCE = 1
  attr_reader :balance
  attr_accessor :in_journey

  def initialize(balance = 0)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    @balance + amount <= LIMIT ? @balance += amount : exceeds_balance
  end

  def deduct(amount)
    @balance -= amount
  end

  def touch_in
    raise "Does not have the minimum amount" if @balance < MINIMUM_BALANCE
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  private
  def exceeds_balance
    raise "Exceeds balance limit of #{LIMIT}"
  end

end
