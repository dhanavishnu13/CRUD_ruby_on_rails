# spec/models/expense_spec.rb
require 'rails_helper'

RSpec.describe Expense, type: :request do


  # Test that the expense model has the expected associations and validations
  it { should belong_to(:user) }
  it { should validate_presence_of(:payee_name) }
  it { should validate_presence_of(:amount) }

  it 'creates a valid expense record' do
    user = User.create(email: 'vishnu@example.com', password: 'password123')
    expense = Expense.new(
      payee_name: 'Jio',
      category: 'Office Supplies',
      description: 'Purchase of SIM card',
      amount: 100.00,
      user: user,
      due_date: Date.today + 7.days,
      status: 'Pending'
    )
    expect(expense).to be_valid
  end
end
