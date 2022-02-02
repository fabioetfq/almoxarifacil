class TransactionsController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]
  before_action :set_material, only: [:create, :sale]
  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new
    @transaction.material = @material
    @transaction.user = current_user
    @transaction.completed = false
    @transaction.delivered = false
    @transaction.amount = cookie[:cart_amount]
    if @transaction.save!
      redirect_to materials_path
    else
      render :new
    end
  end

  def cart
    # Verificar "Janela de Transferência"
    @transaction = Transaction.where(user_id: current_user, delivered: false)
  end

  def edit; end

  def sale
    # Verificar em "Janela de Transferência" como acontece a definição da variável @transactions
    # Talvez aqui seja o momento de atualizar as quantidades dos materiais.
    @transactions.each do |t|
      t.update(delivered: true)
    end
    redirect_to root_path, notice: "Itens entregues com sucesso"
  end

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

  def set_material
    @material = Material.find(params[:material_id])
  end

  def transaction_params
    params.require(:transaction).permit(:delivered, :completed, :amount, :material_id, :user_id)
  end
end
