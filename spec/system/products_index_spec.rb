require 'rails_helper'

RSpec.describe "Products index", type: :system do
  before do
    driven_by(:rack_test)
  end

  let!(:product1) { create(:product, name: "Product 1", price: 10.00, stock: 5) }
  let!(:product2) { create(:product, name: "Product 2", price: 20.00, stock: 10) }
  let!(:product3) { create(:product, name: "Product 3", price: 30.00, stock: 15) }

  it "displays a list of products" do
    visit products_path
    
    expect(page).to have_content("Products")
    expect(page).to have_content("Product 1")
    expect(page).to have_content("Product 2")
    expect(page).to have_content("Product 3")
  end

  it "allows searching for products" do
    visit products_path
    
    fill_in "Search by name:", with: "Product 1"
    click_button "Apply Filters"
    
    expect(page).to have_content("Product 1")
    expect(page).not_to have_content("Product 2")
    expect(page).not_to have_content("Product 3")
  end

  it "allows filtering products by price range" do
    visit products_path
    
    fill_in "Min Price:", with: "15"
    fill_in "Max Price:", with: "25"
    click_button "Apply Filters"
    
    expect(page).to have_content("Product 2")
    expect(page).not_to have_content("Product 1")
    expect(page).not_to have_content("Product 3")
  end

  it "allows sorting products" do
    visit products_path
    
    select "Price: Low to High", from: "Sort by:"
    click_button "Apply Filters"
    
    expect(page.body.index("Product 1")).to be < page.body.index("Product 2")
    expect(page.body.index("Product 2")).to be < page.body.index("Product 3")
  end

  it "displays a message when no products are found" do
    visit products_path
    
    fill_in "Search by name:", with: "Nonexistent Product"
    click_button "Apply Filters"
    
    expect(page).to have_content("No products found")
    expect(page).to have_content("Sorry, no products match your current search criteria or filters.")
  end

  it "allows clearing filters" do
    visit products_path(search: "Product 1")
    
    expect(page).to have_content("Product 1")
    expect(page).not_to have_content("Product 2")
    
    click_link "Clear Filters"
    
    expect(page).to have_content("Product 1")
    expect(page).to have_content("Product 2")
    expect(page).to have_content("Product 3")
  end
end