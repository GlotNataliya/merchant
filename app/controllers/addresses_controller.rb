# frozen_string_literal: true

class AddressesController < ApplicationController
  before_action :set_address, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @addresses = current_user.addresses.order(created_at: :desc)
  end

  def show; end

  def new
    @address = current_user.addresses.build(address_params)
  end

  def edit; end

  def create
    @address = current_user.addresses.build(address_params)
    find_order

    respond_to do |format|
      if @address.save
        format.html { redirect_to request.referer, notice: t(".notice") }
        format.turbo_stream { flash.now[:notice] = t(".notice") }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def update
    if @address.update(address_params)
      respond_to do |format|
        format.html { redirect_to request.referer, notice: t(".notice") }
        format.turbo_stream { flash.now[:notice] = t(".notice") }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy

    respond_to do |format|
      format.html { redirect_to request.referer, notice: t(".notice") }
      format.turbo_stream { flash.now[:notice] = t(".notice") }
    end
  end

  private

  def set_address
    @address = current_user.addresses.find(params[:id])
  end

  def address_params
    params.fetch(:address, {}).permit(:country, :line1, :line2, :city, :state, :zip, :user_id)
  end

  def find_order
    @order = Order.find_by(id: session[:order_id]) || current_user.orders.last
  end
end
