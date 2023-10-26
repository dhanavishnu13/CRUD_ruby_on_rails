class AddDueDateToExpenses < ActiveRecord::Migration[7.1]
  def change
    add_column :expenses, :due_date, :date
  end
end
