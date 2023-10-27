class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  # GET /expenses or /expenses.json
  def index
    # Assuming you have a current_user method that returns the current user
    @current_user = current_user
    if user_signed_in?
      
      @expenses = Expense.where(user_id: @current_user.id)
      if params[:order_by_due_date].present?
        @expenses = @expenses.order(:due_date)
      end
      if params[:start_date].present? && params[:end_date].present? && params[:search].present?
        @expenses = @expenses.where(due_date: params[:start_date]..params[:end_date])
        @expenses = @expenses.where("payee_name LIKE ?", "%#{params[:search]}%")
      elsif params[:start_date].present? && params[:end_date].present?
        @expenses = @expenses.where(due_date: params[:start_date]..params[:end_date])
      elsif params[:search].present?
        @expenses = @expenses.where("payee_name LIKE ?", "%#{params[:search]}%")
      end
      @total_amount = @expenses.group(:status).sum(:amount)
      @category_amount = @expenses.group(:category).sum(:amount)
    end
  end 

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    # @expense = Expense.new
    @expense = current_user.expenses.build()
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    # @expense = Expense.new(expense_params)
    @expense = current_user.expenses.build(expense_params)
    respond_to do |format|
      if @expense.save
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully created." }
        format.json { render :show, status: :created, location: @expense }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    respond_to do |format|
      if @expense.update(expense_params)
        format.html { redirect_to expense_url(@expense), notice: "Expense was successfully updated." }
        format.json { render :show, status: :ok, location: @expense }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @expense.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    @expense.destroy!

    respond_to do |format|
      format.html { redirect_to expenses_url, notice: "Expense was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def correct_user
    @expense = current_user.expenses.find_by(id: params[:id])
    redirect_to expenses_path, notice: "Not Authorized To Edit This Expense" if @expense.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:payee_name, :category, :description, :amount, :user_id, :status, :due_date)
    end
end
