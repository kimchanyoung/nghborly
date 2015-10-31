class RequestEventsController < UserActionsController
  def active
    @transactions = Transaction.sort_by_active
    render ''
  end

  def river
    @transactions = Transaction.sort_by_group(current_user.group)
  end

  def history
    @transactions = Transaction.sort_by_user(current_user)
  end

end
