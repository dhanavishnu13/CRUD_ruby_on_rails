json.extract! expense, :id, :payee_name, :category, :description, :amount, :created_at, :updated_at
json.url expense_url(expense, format: :json)
