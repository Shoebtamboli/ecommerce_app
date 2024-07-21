require 'rails_helper'

RSpec.describe "Product show page", type: :system do
  let!(:product) { create(:product, name: "Test Product", description: "A great product", price: 19.99, stock: 10) }

  before do
    driven_by(:rack_test)
    visit product_path(product)
  end

  it "displays product details" do
    expect(page).to have_content("Test Product")
    expect(page).to have_content("A great product")
    expect(page).to have_content("$19.99")
    expect(page).to have_content("Stock: 10")
  end

  it "displays the product thumbnail" do
    expect(page).to have_css("img.w-full.h-96.object-cover")
  end

  it "displays additional product images" do
    expect(page).to have_css("div.grid.grid-cols-4.gap-4")
  end

  it "has an 'Add to Cart' button" do
    expect(page).to have_button("Add to Cart")
  end

  it "has a 'Back to Products' link" do
    expect(page).to have_link("Back to Products", href: products_path)
  end

  context "when product has no thumbnail" do
    let!(:product_without_thumbnail) { create(:product, thumbnail: nil) }

    it "displays a placeholder for missing thumbnail" do
      visit product_path(product_without_thumbnail)
      expect(page).to have_content("No Thumbnail")
    end
  end
end