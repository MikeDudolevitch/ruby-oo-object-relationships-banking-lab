class Transfer
  attr_accessor :sender, :receiver, :status, :amount
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end
  def valid?
    if sender.valid? && receiver.valid?
      true
    else
      false
    end
  end
  def execute_transaction
    if valid? && sender.balance > amount && self.status == "pending"
      receiver.balance += amount
      sender.balance -= amount
      self.status = "complete"
    else
      reject
    end
  end
  def reverse_transfer
    if valid? && sender.balance > amount && self.status == "complete"
      receiver.balance -= amount
      sender.balance += amount
      self.status = "reversed"
    else
      reject
    end
  end
  def reject
    self.status = "rejected"
    "Transaction rejected. Please check your account balance."
  end
end
