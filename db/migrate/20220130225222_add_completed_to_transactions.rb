class AddCompletedToTransactions < ActiveRecord::Migration[6.1]
  def change
    add_column :transactions, :completed, :boolean
  end
end
