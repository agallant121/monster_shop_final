class Merchant::DiscountsController < Merchant::BaseController
  def index
    @discounts = Discount.all
  end

  def show
    @discount = Discount.find(params[:discount_id])
  end

  def new
  end

  def create
    create_discount
  end

  private

  def discount_params
    params.permit(:name, :description, :min_quantity, :max_quantity, :percent)
  end

  def create_discount
    merchant
    discount
    save_or_not_save_discount
  end

  def save_or_not_save_discount
    merchant
    discount
    if discount.save
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
    flash[:notice] = discount.errors.full_messages.to_sentence
    redirect_to "/merchant/discounts/new"
  end

  def merchant
    merchant = current_user.merchant
  end

  def discount
    merchant
    discount = merchant.discounts.create(discount_params)
  end
end
