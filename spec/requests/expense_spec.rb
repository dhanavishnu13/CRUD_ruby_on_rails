require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  describe "create expense" do
    expense= Expense.new(payee_name: 'Jio', category: 'Mobile', description: 'Recharge', amount: 1000, status: 'paid', due_date: '2023-10-27')
    expect(expense) 
  end 
end
