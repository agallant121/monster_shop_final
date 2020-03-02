class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.all
  end

  def show
    discount_for_view_pages
  end

  def new
  end

  def create
    create_discount
  end

  def edit
    discount_for_view_pages
  end

  def update
    update_discount
  end

  def destroy
    # merchant
    discount = Discount.find(params[:discount_id])
    discount.destroy
    redirect_to "/merchant/discounts"
  end

  private

  def discount_params
    params.permit(:name, :description, :min_quantity, :max_quantity, :percent)
  end

  def create_discount
    @discount = discount
    if @discount.save
      saved_discount
    else
      discount_not_saved
    end
  end

  def saved_discount
    flash[:notice] = "Your discount has been added."
    redirect_to "/merchant/discounts"
  end

  def discount_not_saved
    merchant
    flash[:notice] = @discount.errors.full_messages.to_sentence
    redirect_to "/merchant/discounts/new"
  end

  def merchant
    merchant = current_user.merchant
  end

  def discount
    merchant
    discount = merchant.discounts.new(discount_params)
  end

  def update_discount
    merchant
    discount = Discount.find(params[:discount_id])
    if discount.update(discount_params)
      flash[:notice] = "Your discount changes have been saved."
      redirect_to "/merchant/discounts/#{discount.id}"
    else
      flash[:notice] = "Your discount changes have not been saved."
      redirect_to "/merchant/discounts/#{discount.id}/edit"
      #add helper methods in the morning
    end
  end

  def discount_for_view_pages
    @discount = Discount.find(params[:discount_id])
  end
end
