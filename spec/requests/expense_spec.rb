# spec/requests/expenses_spec.rb

require 'rails_helper'

RSpec.describe "Expenses", type: :request do
  describe "POST /expenses" do
    it "creates a new expense" do
      # Define the parameters for the new expense
      expense_params = {
        payee_name: 'Jio',
        category: 'Mobile',
        description: 'Recharge',
        amount: 1000,
        status: 'paid',
        due_date: '2023-10-27'
      }

      # Send a POST request to create the expense
      post "/expenses", params: { expense: expense_params }

      # Expect that the request was successful (you can adjust the status code as needed)
      expect(response).to have_http_status(:created)

      # Expect that the expense was created in the database
      expect(Expense.last).to have_attributes(expense_params)
    end
  end
end
