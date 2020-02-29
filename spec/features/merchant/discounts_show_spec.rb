require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @blockbuster = Merchant.create!(name: 'Blockbuster', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
    @dave = @blockbuster.users.create!(name: "Dave Chappelle", address: "571 Cheater St",
      city: "Colorado Springs", state: "CO", zip: "80206", email: "dave@gmail.com", password: "dave", role: 2)

    @discount_1 = @blockbuster.discounts.create(name: "Ten Percent", description: "Great bulk discount", min_quantity: 10, max_quantity: 19, percent: 10)
    @discount_2 = @blockbuster.discounts.create(name: "Fifteen Percent", description: "Best discount offered", min_quantity: 20, max_quantity: 100, percent: 20)

    visit '/login'
    expect(current_path).to eq('/login')

    fill_in :email, with: @dave.email
    fill_in :password, with: 'dave'
    click_button 'Log In'

    click_link "Merchant Dashboard"
    click_link "Discounts"
  end

  it "discount names are links to their show pages" do
    expect(page).to have_link(@discount_2.name)
    click_link "#{@discount_1.name}"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")
    expect(page).to have_content(@discount_1.name)
    expect(page).to have_content("Description: #{@discount_1.description}")
    expect(page).to have_content("Minimum Item Quantity: #{@discount_1.min_quantity}")
    expect(page).to have_content("Maximum Item Quantity: #{@discount_1.max_quantity}")
    expect(page).to have_content("Discount Percentage: #{@discount_1.percent}")
  end
end
