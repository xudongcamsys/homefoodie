feature "Pick event addresss", js: true do 

  scenario "successfully" do 
    user = create(:user)

    signin(user.email, user.password)

    visit new_user_event_path(user)

    fill_in "address", with: "new york"

    expect(page).to have_field("address", with: "new york, NY, United States")
  end

end