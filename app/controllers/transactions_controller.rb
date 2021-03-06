class TransactionsController < ApplicationController
  before_action :find, only: [:show, :edit, :update, :destroy]
  before_action :set_material, only: [:create, :sale]
  before_action :set_user, only: [:cart]
  before_action :find_in_cart, only: [:create]
  before_action :cart, only: [:update]

  def index
    @transactions = Transaction.all
  end

  def show; end

  def new
    @transaction = Transaction.new
  end

  def create
    unless @transaction # Avoid new material already in cart.
      @transaction = Transaction.new
      @transaction.material = @material
      @transaction.user = current_user
      @transaction.completed = false
      @transaction.delivered = false
      @transaction.amount = 1
      if @transaction.save!
        redirect_to materials_path, notice: " #{@transaction.material.name} adicionado ao carrinho! "
      else
        render :new
      end
    else
      redirect_to cart_path
    end
  end

  def cart
    # Verificar "Janela de Transferência"
    @transactions = Transaction.where(user_id: current_user, delivered: false)
  end

  def edit; end
  
  def update # Confirmação do Pedido
    @transactions.each do |t|
      t.update(transaction_params)
    end
    redirect_to transaction_path(@transaction)
  end

  def sale
    # Verificar em "Janela de Transferência" como acontece a definição da variável @transactions
    # Talvez aqui seja o momento de atualizar as quantidades dos materiais.
    @transactions.each do |t|
      t.update(delivered: true)
    end
    redirect_to root_path, notice: "Itens entregues com sucesso"
  end

  def destroy
    @transaction.destroy
    redirect_to cart_path
  end

  private

  def find
    @transaction = Transaction.find(params[:id])
  end

  def find_in_cart # Verifica se há alguma instância de Transaction com material já presente no carrinho.
    @transaction = Transaction.exists?(material_id: @material.id)
  end

  def set_material
    @material = Material.find(params[:material_id])
  end

  def transaction_params
    params.require(:transaction).permit(:delivered, :completed, :amount, :material_id, :user_id)
  end

  def set_user
    @user = current_user
  end
end
