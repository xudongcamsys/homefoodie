feature "user creates comment", js: true do
  
  scenario "successfully" do 
    user = create(:user)
    dish = create(:dish, user: user)

    signin(user.email, user.password)

    visit user_dish_path(user, dish)


    fill_in 'comment_comment', with: 'Testing comment'
    click_button 'Create Comment'

    # wait_for_ajax

    # comment = Comment.last
    expect(page).to have_css(".comments p", text: "Testing comment")
    # expect(page).to have_css("#comment-#{comment.id} p", text: "Testing comment")

  end

  # empty

  # avatar, user name etc.

end