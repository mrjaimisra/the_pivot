require 'rails_helper'

RSpec.feature "Guest visits photographer page", type: :feature do
  let!(:photo)        { Fabricate(:photo) }
  let!(:photographer) { Store.first }

  scenario "successfully" do
    visit root_path

    click_link "Photographers"
    click_link photographer.name

    expect(current_path).to eq(photographer_photos_path(photographer.url))
  end

  scenario "and visits individual photo page" do
    visit photographer_photos_path(photographer.url)

    page.first(".photo").click

    expect(current_path).to eq(photo_path(photo))
  end
end
