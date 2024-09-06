class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.timestamps
      t.string :type, null: false
      t.string :name, null: false
      t.string :phone, null: false
    end
  end
end
