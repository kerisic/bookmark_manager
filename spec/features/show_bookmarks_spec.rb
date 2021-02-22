feature 'User can see bookmarks' do
  scenario 'see all bookmarks' do
    visit '/bookmarks'

    expect(page).to have_content 'http://theguardian.com'
    expect(page).to have_content 'http://buzzfeed.com'
    expect(page).to have_content 'http://bbc.com'
  end
end
