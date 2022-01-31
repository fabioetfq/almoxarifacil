class TransactionsController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]
  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save!
      redirect_to transaction_path(@transaction)
    else
      render :new
    end
  end

  def edit; end

  def update
    @transaction.update(transaction_params)
    redirect_to transaction_path(@transaction)
  end

  def destroy
    @transaction.destroy
    redirect_to materials_path
  end

  private

  def find
    @transaction = Transaction.find(params[:id])
  end

  def transaction_params
    params.require(:transaction).permit(:delivered, :completed, :material_id, :user_id)
  end
end
