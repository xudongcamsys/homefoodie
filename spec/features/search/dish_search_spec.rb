feature "Dish search" do 

  before(:each) do 
    search_reindex Dish
  end

  scenario "user can see dish search page" do 
    visit root_path

    click_link "Find dish"

    expect(page).to have_css("h1", text: "Find Dish")
  end

  scenario "user can search dishes" do
    visit dish_search_path

    user = create(:user, name: 'Adam Silva')
    create(:dish, user: user, name: 'Roasted Chicken')

    search_reindex Dish
    
    fill_in  'q', :with => 'Chicken'
    click_button 'Go'

    expect(page).to have_css('h5', 'Roasted Chicken')
  end

end