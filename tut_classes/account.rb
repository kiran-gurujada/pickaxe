class Account
  attr_accessor :balance

  def initialize(balance)
    @balance = balance
  end
end

class Transaction
  def initialize(account_a, account_b)
    @account_a = account_a
    @account_b = account_b
  end

  # we make these methods private, so only transactional methods are
  # exposed.
  private

  def debit(account, amount)
    account.balance -= amount
  end
  def credit(account, amount)
    account.balance += amount
  end

  public
  def transfer(amount)
    debit(@account_a, amount)
    credit(@account_b, amount)
  end
end

# protected access is usef when objects need to access the internal
# state of other objects of the same class.
#
# e.g. we may want to allow individual Account objects to compare
# their cleared balances, but to hid those balances from the
# rest of the world (perhaps because they would be presented in a 
# different form)

class Account
  attr_reader :cleared_balance # reader method
  protected :cleared_balance # only available to other Account objects

  def greater_balance_than?(other)
    @cleared_balance > other.cleared_balance
  end
end
