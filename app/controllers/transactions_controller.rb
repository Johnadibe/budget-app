class TransactionsController < ApplicationController
  def index
    @group = current_user.groups.find(params[:category_id])
    @transactions = @group.ordered_transactions
  end

  def new
    @categories = current_user.ordered_groups
    operation = Operation.new
    id = params[:category_id]
    respond_to do |format|
      format.html { render :new, locals: { operation:, id: } }
    end
  end

  def create
    name = transaction_params[:name]
    amount = transaction_params[:amount]
    categories = transaction_params[:categories]
    transaction = Operation.new(name:, amount:)
    transaction.user = current_user
    respond_to do |format|
      format.html do
        if transaction.save
          create_relation(categories, transaction, params[:id])
        else
          @categories = current_user.groups
          flash.now[:alert] = 'Error: Please make sure to fill all fields with the proper input'
          render :new, status: 422, locals: { operation: transaction, id: params[:categories_id] }
        end
      end
    end
  end

  private

  def transaction_params
    params.require(:operation).permit(:name, :amount, categories: [])
  end

  def create_relation(categories, transaction, id)
    # First record is empty so it gets deleted
    categories.shift

    # Id no category was selected
    if categories.empty?
      @categories = current_user.groups
      flash.now[:alert] = 'Error: Please make sure to fill all fields with the proper input'
      render :new, status: 422, locals: { operation: transaction, id: }
      return
    end

    first_category_id = categories[0]

    # Itereates through the cateories and create relationships witht the operation
    categories.each_with_index do |category_id, _index|
      group = Group.find(category_id)
      MoneyGroup.create(group:, operation: transaction)
    end
    flash[:notice] = 'Transaction created successfully'
    redirect_to(category_transactions_path(category_id: first_category_id))
  end
end
