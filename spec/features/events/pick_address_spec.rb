feature "Pick event addresss", js: true do 

  scenario "successfully" do 
    user = create(:user)

    signin(user.email, user.password)

    visit new_user_event_path(user)

    fill_in "Address", with: "new york"

    expect(page).to have_content("New York, NY, United States")
  end

end