require "rails_helper"

RSpec.feature "Store admin" do
  before do
    build_roles
  end

  scenario "can edit the store information" do
    store       = Fabricate(:store)
    store_admin = Fabricate(:user)
    store_admin.update_attributes(store_id: store.id)
    store_admin.roles << Role.find_by(name: "store_admin")

    allow_any_instance_of(ApplicationController).to receive(
      :current_user).and_return(store_admin)

    visit root_path

    click_link "Edit Store"

    expect(page).to have_content "Edit Store"

    fill_in "Store Name", with: "Sandra Smith Photography"
    fill_in "Email",      with: "sandra@example.com"

    click_button "Update Store"

    expect(current_path).to eq photographer_path(store.url)
    skip
    expect(page).to have_content "Sandra Smith"
    expect(page).to have_content 'sandra@example.com'
  end
end