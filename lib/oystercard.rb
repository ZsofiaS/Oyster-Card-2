class Oystercard
  LIMIT = 90
  attr_reader :balance

  def initialize(balance = 0)
    @balance = balance
  end

  def top_up(amount)
    @balance + amount <= LIMIT ? @balance += amount : exceeds_balance
  end

  def deduct(amount)
    @balance -= amount
  end

  private
  def exceeds_balance
    raise "Exceeds balance limit of #{LIMIT}"
  end

end
