class PaymentsController < ApplicationController
  def new
    @lesson_order = current_user.lesson_orders.where(state: 'pending').find(params[:lesson_order_id])
  end

end
