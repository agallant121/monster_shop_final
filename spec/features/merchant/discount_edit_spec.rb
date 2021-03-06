require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    Merchant.destroy_all
    Discount.destroy_all

    @front_row_video = Merchant.create!(name: 'Front Row Video', address: '874 New Hampshire Blvd', city: 'Bangor', state: 'PA', zip: 80218, enabled: true)
    @blockbuster = Merchant.create!(name: 'Blockbuster', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
    @dave = @blockbuster.users.create!(name: "Dave Chappelle", address: "571 Cheater St",
      city: "Colorado Springs", state: "CO", zip: "80206", email: "dave@gmail.com", password: "dave", role: 2)

    @discount_1 = @blockbuster.discounts.create(name: "Ten Percent", description: "Great bulk discount", min_quantity: 10, percent: 10)
    @discount_2 = @blockbuster.discounts.create(name: "Fifteen Percent", description: "Best discount offered", min_quantity: 20, percent: 20)
    @discount_3 = @front_row_video.discounts.create(name: "Test Discount", description: "Competitor's Discount", min_quantity: 20, percent: 50)

    visit '/login'
    expect(current_path).to eq('/login')

    fill_in :email, with: @dave.email
    fill_in :password, with: 'dave'
    click_button 'Log In'

    click_link "Merchant Dashboard"
    expect(current_path).to eq("/merchant")
    click_link "Discounts"
  end

  it "has a link to edit the discount on the discount's show page" do

    click_link "#{@discount_1.name}"
    click_link "Edit"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")

    fill_in :name, with: "Edited Discount"

    click_on "Update"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}")
    expect(page).to have_content("Edited Discount")
    expect(page).to_not have_content("Ten Percent")
  end

  it "must have all fields complete to edit a form" do
    click_link "#{@discount_1.name}"
    click_link "Edit"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")

    fill_in :name, with: ""

    click_on "Update"
    expect(current_path).to eq("/merchant/discounts/#{@discount_1.id}/edit")
    expect(page).to have_content("Your discount changes have not been saved.")
  end

  it "only shows discounts associated with logged in merchant" do
    expect(page).to have_content("Fifteen Percent")
    expect(page).to have_content("Ten Percent")
    expect(page).to_not have_content("Test Discount")
  end
end
