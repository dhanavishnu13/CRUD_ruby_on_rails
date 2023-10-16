class CreateExpenses < ActiveRecord::Migration[7.1]
  def change
    create_table :expenses do |t|
      t.string :payee_name
      t.string :category
      t.string :description
      t.string :amount

      t.timestamps
    end
  end
end
