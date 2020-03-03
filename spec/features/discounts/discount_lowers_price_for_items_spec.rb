require 'rails_helper'

RSpec.describe "As a visitor" do
  before :each do
    @blockbuster = Merchant.create!(name: 'Blockbuster', address: '123 Main St', city: 'Denver', state: 'CO', zip: 80218, enabled: true)
    @dave = @blockbuster.users.create!(name: "Dave Chappelle", address: "571 Cheater St",
      city: "Colorado Springs", state: "CO", zip: "80206", email: "dave@gmail.com", password: "dave", role: 2)

    @discount_1 = @blockbuster.discounts.create!(name: "Ten Percent", description: "Great bulk discount", min_quantity: 3, percent: 10)
    @discount_2 = @blockbuster.discounts.create!(name: "Fifteen Percent", description: "Best discount offered", min_quantity: 5, percent: 20)

    @ogre = @blockbuster.items.create!(name: 'Ogre', description: "I'm an Ogre!", price: 10, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )
    @giant = @blockbuster.items.create!(name: 'Giant', description: "I'm a Giant!", price: 50, image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTaLM_vbg2Rh-mZ-B4t-RSU9AmSfEEq_SN9xPP_qrA2I6Ftq_D9Qw', active: true, inventory: 20 )
    @tire = @blockbuster.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", active: true, inventory: 20)
    @maxxis_DH = @blockbuster.items.create!(name: "Maxxis DHR", description: "Awesome grp!", price: 150, image: "https://i.ebayimg.com/images/i/142126821783-0-1/s-l1000.jpg", active: true, inventory: 20)

    visit '/login'
    expect(current_path).to eq('/login')

    fill_in :email, with: @dave.email
    fill_in :password, with: 'dave'
    click_button 'Log In'
  end

  it "shows the cart total price without the discount" do
    expect(page).to_not have_content("Discounted Total:")
  end

  it "applies discount when item quantity is greater >=3" do
    visit item_path(@ogre)
    click_button 'Add to Cart'
    visit "/cart"

    within"#item-#{@ogre.id}" do
      click_button 'More of This!'
    end
    expect(page).to_not have_content("Discounted Total:")

    within"#item-#{@ogre.id}" do
      click_button 'More of This!'
    end
    expect(page).to have_content("Total: $30.00")
    expect(page).to have_content("Discounted Total: $27.00")

    within"#item-#{@ogre.id}" do
      click_button 'Less of This!'
    end
    expect(page).to_not have_content("Discounted Total:")
  end

  it "chooses the greater discount" do
    visit item_path(@ogre)
    click_button 'Add to Cart'
    visit "/cart"

    within"#item-#{@ogre.id}" do
      click_button 'More of This!'
      click_button 'More of This!'
      click_button 'More of This!'
      click_button 'More of This!'
    end
    expect(page).to have_content("Discounted Total: $40.00")
  end
end
