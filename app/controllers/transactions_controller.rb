class TransactionsController < UserActionsController

  def river
    @transactions = Transaction.sort_by_group(current_user.group).limit(25)

    if request.xhr?
      render 'transactions/index.html.erb', layout: false
    else
      render 'transactions/index.html.erb'
    end
  end

  def history
    @transactions = Transaction.sort_by_user(current_user).limit(25)
    if request.xhr?
      render 'transactions/index.html.erb', layout: false
    else
      render 'transactions/index.html.erb'
    end
  end

end
