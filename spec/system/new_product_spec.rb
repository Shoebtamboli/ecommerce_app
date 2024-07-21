require 'rails_helper'

RSpec.describe "New product form", type: :system do
  before do
    driven_by(:rack_test)
    visit new_product_path
  end

  it "displays the new product form" do
    expect(page).to have_content("New Product")
    expect(page).to have_field("Name")
    expect(page).to have_field("Description")
    expect(page).to have_field("Price")
    expect(page).to have_field("Stock")
    expect(page).to have_field("Thumbnail")
    expect(page).to have_field("Images")
    expect(page).to have_button("Create Product")
  end

  it "creates a new product with valid inputs" do
    fill_in "Name", with: "New Test Product"
    fill_in "Description", with: "A brand new product"
    fill_in "Price", with: "29.99"
    fill_in "Stock", with: "100"
    attach_file "Thumbnail", Rails.root.join("spec/fixtures/files/test_image.jpg")

    expect {
      click_button "Create Product"
    }.to change(Product, :count).by(1)

    expect(page).to have_content("Product was successfully created.")
    expect(page).to have_content("New Test Product")
  end

  it "displays error messages with invalid inputs" do
    click_button "Create Product"

    expect(page).to have_content("prohibited this product from being saved")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Price can't be blank")
    expect(page).to have_content("Stock can't be blank")
    expect(page).to have_content("Thumbnail must be attached")
  end

  it "has a 'Back' link" do
    expect(page).to have_link("Back", href: products_path)
  end
end