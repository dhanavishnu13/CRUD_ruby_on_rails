require 'rails_helper'

RSpec.describe Expense, type: :model do
  it "validates the presence of payee_name" do
    expense = Expense.validate_name(payee_name: nil)
    expect(expense).not_to be_valid
    expect(expense.errors[:payee_name]).to include("can't be blank")
  end
end
