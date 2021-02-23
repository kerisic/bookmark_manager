feature 'To be able to remember which sites the user likes' do
  scenario 'user saves a bookmark for the site' do
    visit ('/bookmarks')
    fill_in :url, with: 'http://www.sushi.com'
    click_button 'Submit'
    expect(page).to have_content('http://www.sushi.com')
  end
end
