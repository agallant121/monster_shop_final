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
    expect(current_path).to eq("/merchant")
  end

  it "has a link to the discounts index page" do

  click_link "Discounts"
  expect(current_path).to eq("/merchant/discounts")

    within"#discount-#{@discount_1.id}" do
      expect(page).to have_link(@discount_1.name)
    end

    within"#discount-#{@discount_2.id}" do
      expect(page).to have_link(@discount_2.name)
    end
  end

  it "has a link to add a new discount from merchant discounts index page" do
    click_link "Discounts"
    expect(current_path).to eq("/merchant/discounts")

    click_link "Add Discount:"
    expect(current_path).to eq("/merchant/discounts/new")

    fill_in :name, with: "New Discount"
    fill_in :description, with: "Newest discount available"
    fill_in :min_quantity, with: 5
    fill_in :max_quantity, with: 9
    fill_in :percent, with: 50
    click_button "Submit"

    expect(current_path).to eq("/merchant/discounts")
    expect(page).to have_content("New Discount")
    expect(page).to have_content("Your discount has been added.")
  end

  it "must have all information filled out to add discount" do
    click_link "Discounts"
    expect(current_path).to eq("/merchant/discounts")

    click_link "Add Discount:"
    expect(current_path).to eq("/merchant/discounts/new")

    fill_in :name, with: "New Discount"
    fill_in :description, with: "Newest discount available"
    fill_in :min_quantity, with: 5
    fill_in :max_quantity, with: ""
    fill_in :percent, with: 50
    click_button "Submit"

    expect(current_path).to eq("/merchant/discounts/new")
    expect(page).to have_content("Max quantity can't be blank")
  end

  it "has a link to delete a discount next to each discount on the index page" do
    click_link "Discounts"
    expect(current_path).to eq("/merchant/discounts")
    expect(Discount.all.count).to eq(2)

    within"#discount-#{@discount_1.id}" do
      click_link "Delete"
    end
    expect(current_path).to eq("/merchant/discounts")
    expect(page).to_not have_content(@discount_1.name)
    expect(Discount.all.count).to eq(1)
  end
end
