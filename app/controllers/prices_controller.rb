class PricesController < ApplicationController
  before_action :set_price, only: %i[ show edit update destroy ]
  before_action :set_param, only: %i[ new edit create update ]

  # GET /prices or /prices.json
  def index
    @prices = Price.includes(:item)
  end

  # GET /prices/1 or /prices/1.json
  def show
  end

  # GET /prices/new
  def new
    @price = Price.new
  end

  # GET /prices/1/edit
  def edit
  end

  # POST /prices or /prices.json
  def create
    @price = Price.new(price_params)

    respond_to do |format|
      if @price.save
        format.html { redirect_to prices_url, notice: "Price was successfully created." }
        format.json { render :show, status: :created, location: @price }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prices/1 or /prices/1.json
  def update
    respond_to do |format|
      if @price.update(price_params)
        format.html { redirect_to prices_url, notice: "Price was successfully updated." }
        format.json { render :show, status: :ok, location: @price }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @price.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prices/1 or /prices/1.json
  def destroy
    @price.destroy

    respond_to do |format|
      format.html { redirect_to prices_url, notice: "Price was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def get_price
    @item = Item.find_by(id: params[:id])
    @price = Price.where(item_id: @item.id, state: true).where("'#{Date.today}' >= start_date AND '#{Date.today}' <= end_date").order("start_date DESC").first
    @tax = Tax.find_by(year: Date.today.year.to_i, state: true)
    render json: {price: @price.price.to_f, percentage_ppn: @tax.percentage.to_f, price_include: @price.price.to_f + (@price.price.to_f * @tax.percentage.to_f / 100)}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price
      @price = Price.find(params[:id])
    end

    def set_param
      @items = Item.all.order("SKU ASC")
    end

    # Only allow a list of trusted parameters through.
    def price_params
      params.require(:price).permit(:item_id, :price, :start_date, :end_date, :state)
    end
end
