require "payfast/onsite_payments"

class CartsController < ApplicationController
  def index
  end

  def new
    @cart = Cart.new
  end

  def create
    payload = {
      email_address: cart_params[:email_address],
      amount: cart_params[:amount],
      item_name: cart_params[:item_name],
    }

    payment_identifier = Payfast::OnsitePayments.requestPayment(payload)

    @cart = Cart.new(cart_params)
    @cart.payment_uuid = payment_identifier["uuid"]

    if @cart.save
      redirect_to make_payment_cart_path(@cart)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def make_payment
    @cart = Cart.find(params[:id])
  end

  def success
    @cart = Cart.find(params[:id])
    @cart.is_paid = true
    redirect_to carts_path, notice: "Transcation Successful"
  end

  def failure
    redirect_to carts_path, notice: "Transcation Canceled"
  end

  private

  def cart_params
    params.require(:cart).permit(:item_name, :amount, :email_address)
  end
end
