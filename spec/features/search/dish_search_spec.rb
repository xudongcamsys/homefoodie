feature "User can search dishes" do 

  before(:each) do 
    visit dish_search_path

    user = create(:user, name: 'Adam Silva')
    create(:dish, user: user, name: 'Roasted Chicken')

    search_reindex "Dish"
  end

  scenario "using case senstive word" do
    fill_in  'q', :with => 'Chicken'
    click_button 'Go'

    expect(page).to have_css('h5', 'Roasted Chicken')
  end

  scenario "in insensitive case" do
    fill_in  'q', :with => 'chicken'
    click_button 'Go'

    expect(page).to have_css('h5', 'Roasted Chicken')
  end

  scenario "in partial match" do
    fill_in  'q', :with => 'roast'
    click_button 'Go'

    expect(page).to have_css('h5', 'Roasted Chicken')
  end

end