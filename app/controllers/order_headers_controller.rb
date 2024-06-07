class OrderHeadersController < ApplicationController
  before_action :set_order_header, only: %i[ show edit update destroy ]
  before_action :set_param, only: %i[ new edit create update ]

  # GET /order_headers or /order_headers.json
  def index
    @order_headers = OrderHeader.all
  end

  # GET /order_headers/1 or /order_headers/1.json
  def show
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
        format.html { redirect_to order_header_url(@order_header), notice: "Order header was successfully created." }
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
        format.html { redirect_to order_header_url(@order_header), notice: "Order header was successfully updated." }
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order_header
      @order_header = OrderHeader.find(params[:id])
    end

    def set_param
      @items = Item.all.order("SKU ASC")
    end

    # Only allow a list of trusted parameters through.
    def order_header_params
      params.require(:order_header).permit(
        :number, :customer_name, :invoice_number, :invoice_date, :state,
        order_details_attributes: [
          :id, :order_header_id, :item_id, :qty_request, :qty_available, :price_include, :price_exclude, :percentage_ppn, :is_confirm, :_destroy,
        ]
      )
    end
end
