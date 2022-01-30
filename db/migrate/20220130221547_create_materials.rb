class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|
      t.string :name
      t.string :type
      t.integer :qty

      t.timestamps
    end
  end
end
