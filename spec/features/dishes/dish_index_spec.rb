feature "User view dishes", type: :feature do
  
  scenario "logged in user see own dishes" do
    user = create(:user, name: "Joe Bloggs")
    dish = create(:dish, user: user, name: 'Thai Mussels')

    signin(user.email, user.password)

    click_link "My dishes"

    expect(page).to have_css("h1", text: "Joe Bloggs's dishes")

    expect(page).to have_css("h5", text: "Thai Mussels")
  end

  scenario "guest user cannot see My Dishes link" do
    visit root_path 

    expect(page).to_not have_css("a", text: "My dishes")
  end

end
