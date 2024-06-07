class OrderHeadersController < ApplicationController
  before_action :set_order_header, only: %i[ show edit update destroy ]
  before_action :set_param, only: %i[ new edit create update ]

  # GET /order_headers or /order_headers.json
  def index
    @order_headers = OrderHeader.select("order_headers.id as id, order_headers.number as number, order_headers.invoice_number as invoice_number, 
      order_headers.invoice_date as invoice_date, order_headers.customer_name as customer_name, order_headers.state as state, SUM(order_details.price_exclude) as total_price_exclude")
      .joins("left join order_details on order_details.order_header_id = order_headers.id")
      .group("order_headers.id, order_headers.number, order_headers.invoice_number, 
      order_headers.invoice_date, order_headers.customer_name, order_headers.state")
      .order("order_headers.number DESC")
  end

  # GET /order_headers/1 or /order_headers/1.json
  def show
    @order_details = @order_header.order_details.includes(:item)
  end

  # GET /order_headers/new
  def new
    @order_header = OrderHeader.new
  end

  # GET /order_headers/1/edit
  def edit
  end

  # POST /order_headers or /order_headers.json
  def create
    @order_header = OrderHeader.new(order_header_params)

    respond_to do |format|
      if @order_header.save
        @order_header.update_columns(number: generateOrderNumber("ORD"))
        format.html { redirect_to order_headers_url, notice: "Order header was successfully created." }
        format.json { render :show, status: :created, location: @order_header }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /order_headers/1 or /order_headers/1.json
  def update
    respond_to do |format|
      if @order_header.update(order_header_params)
        format.html { redirect_to order_headers_url, notice: "Order header was successfully updated." }
        format.json { render :show, status: :ok, location: @order_header }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order_header.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_headers/1 or /order_headers/1.json
  def destroy
    @order_header.destroy

    respond_to do |format|
      format.html { redirect_to order_headers_url, notice: "Order header was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def on_process
    @order_header = OrderHeader.find_by(id: params[:id])
    if @order_header.update_columns(state: 1)
      respond_to do |format|
        format.html { redirect_to order_headers_url, notice: "Order was successfully on processed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to order_headers_url, alert: "Order was unsuccessfully on processed." }
        format.json { head :no_content }
      end
    end
  end

  def on_check
    @order_header = OrderHeader.find_by(id: params[:id])
    @order_details = @order_header.order_details.includes(:item)
  end

  def submit_on_check
    @order_header = OrderHeader.find_by(id: params[:id])
    params["order_details"].each do |order_detail|
      @order_detail = OrderDetail.find_by(id: order_detail["id"])
      @order_detail.qty_available = order_detail["qty_available"].to_i
      @order_detail.save
    end

    if @order_header.update_columns(state: 2)

      respond_to do |format|
        format.html { redirect_to order_headers_url, notice: "Order was successfully on checked." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to order_headers_url, notice: "Order was unsuccessfully on checked." }
        format.json { head :no_content }
      end
    end
  end
  
  def on_confirm
    @order_header = OrderHeader.find(params[:id])
    @order_details = @order_header.order_details.includes(:item)
  end

  def submit_confirm
    @order_header = OrderHeader.find_by(id: params[:id])
    if @order_header.update_columns(state: 3, invoice_number: generateInvoiceNumber("INV"), invoice_date: Date.today)
      @order_details = @order_header.order_details
      @order_details.each do |order_detail|
        @stock = Stock.find_by(item_id: order_detail.item_id)
        @stock.update_columns(current_qty: @stock.current_qty - order_detail.qty_available)
        order_detail.update_columns(is_confirm: true)
      end

      respond_to do |format|
        format.html { redirect_to order_headers_url, notice: "Order was successfully confirmed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to order_headers_url, alert: "Order was unsuccessfully confirmed." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_header
      @order_header = OrderHeader.find(params[:id])
    end

    def set_param
      @items = Item.where(state: true).order("SKU ASC")
    end

    # Only allow a list of trusted parameters through.
    def order_header_params
      params.require(:order_header).permit(
        :number, :customer_name, :invoice_number, :invoice_date, :state,
        order_details_attributes: [
          :id, :item_id, :qty_request, :qty_available, :price_include, :price_exclude, :percentage_ppn, :is_confirm, :_destroy,
        ]
      )
    end
end
