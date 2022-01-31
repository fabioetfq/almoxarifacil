class FixColumnName < ActiveRecord::Migration[6.1]
  def change
    change_table :materials do |t|
      t.rename :type, :category
    end
  end
end
