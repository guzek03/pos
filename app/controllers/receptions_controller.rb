class ReceptionsController < ApplicationController
  before_action :set_reception, only: %i[ show edit update destroy ]
  before_action :set_param, only: %i[ new edit create update ]

  # GET /receptions or /receptions.json
  def index
    @receptions = Reception.includes(:item)
  end

  # GET /receptions/1 or /receptions/1.json
  def show
  end

  # GET /receptions/new
  def new
    @reception = Reception.new
  end

  # GET /receptions/1/edit
  def edit
  end

  # POST /receptions or /receptions.json
  def create
    @reception = Reception.new(reception_params)

    respond_to do |format|
      if @reception.save
        @reception.update_columns(number: generateReceptionNumber("RCPT"))
        format.html { redirect_to receptions_url, notice: "Reception was successfully created." }
        format.json { render :show, status: :created, location: @reception }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reception.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /receptions/1 or /receptions/1.json
  def update
    respond_to do |format|
      if @reception.update(reception_params)
        format.html { redirect_to receptions_url, notice: "Reception was successfully updated." }
        format.json { render :show, status: :ok, location: @reception }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reception.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receptions/1 or /receptions/1.json
  def destroy
    @reception.destroy

    respond_to do |format|
      format.html { redirect_to receptions_url, notice: "Reception was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def confirm
    @reception = Reception.find_by(id: params[:id])
    if @reception.update_columns(is_confirm: true)
      @stock = Stock.find_by(item_id: @reception.item_id)
      if @stock.present?
        @stock.update_columns(current_qty: @stock.current_qty + @reception.qty)
      else
        @stock = Stock.new
        @stock.item_id = @reception.item_id
        @stock.current_qty = @reception.qty
        @stock.save
      end

      respond_to do |format|
        format.html { redirect_to receptions_url, notice: "Reception was successfully confirmed." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to receptions_url, alert: "Reception was unsuccessfully confirmed." }
        format.json { head :no_content }
      end
    end
  end

  def reject
    @reception = Reception.find_by(id: params[:id])
    if @reception.update_columns(is_confirm: false)
      respond_to do |format|
        format.html { redirect_to receptions_url, notice: "Reception was successfully rejected." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to receptions_url, alert: "Reception was unsuccessfully rejected." }
        format.json { head :no_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reception
      @reception = Reception.find(params[:id])
    end

    def set_param
      @items = Item.all.order("SKU ASC")
    end

    # Only allow a list of trusted parameters through.
    def reception_params
      params.require(:reception).permit(:number, :item_id, :qty, :notes, :is_confirm)
    end
end
