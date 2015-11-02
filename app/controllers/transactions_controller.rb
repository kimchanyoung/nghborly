class TransactionsController < UserActionsController

  def river
    @transactions = Transaction.sort_by_group(current_user.group).limit(25)
    render 'transactions/index.html.erb'
  end

  def history
    @transactions = Transaction.sort_by_user(current_user).limit(25)
    render 'transactions/index.html.erb'
  end

end
