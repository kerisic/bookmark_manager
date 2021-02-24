feature 'To be able to remember which sites the user likes' do
  scenario 'user saves a bookmark for the site' do
    visit('/bookmarks')
    fill_in :url, with: 'http://www.sushi.com'
    fill_in :title, with: 'Sushi'
    click_button 'Submit'
    expect(page).to have_link('Sushi', href: 'http://www.sushi.com')
  end
end
