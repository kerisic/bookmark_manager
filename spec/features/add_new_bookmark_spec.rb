feature 'To be able to remember which sites the user likes' do
  scenario 'user saves a bookmark for the site' do
    visit('/bookmarks')
    fill_in :url, with: 'http://www.sushi.com'
    fill_in :title, with: 'Sushi'
    click_button 'Submit'
    expect(page).to have_link('Sushi', href: 'http://www.sushi.com')
  end

  scenario 'The bookmark must be a valid URL' do
    visit('/bookmarks')
    fill_in('url', with: 'not a real bookmark')
    click_button('Submit')

    expect(page).not_to have_content 'not a real bookmark'
    expect(page).to have_content 'You must submit a valid URL'
  end
end
