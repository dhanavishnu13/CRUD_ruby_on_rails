class ChangeDueDateToNotNull < ActiveRecord::Migration[7.1]
  def up
    change_column :expenses, :payee_name, :string, null: false
    change_column :expenses, :amount, :decimal, null: false
  end
end
