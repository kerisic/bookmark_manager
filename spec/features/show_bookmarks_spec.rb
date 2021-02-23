feature 'User can see bookmarks' do
  scenario 'see all bookmarks' do

    Bookmark.add_bookmark('Makers', 'http://www.makersacademy.com')
    Bookmark.add_bookmark('Destroy', 'http://www.destroyallsoftware.com')
    Bookmark.add_bookmark('Google', 'http://www.google.com')

    visit '/bookmarks'

    expect(page).to have_content 'Makers'
    expect(page).to have_content 'Destroy'
    expect(page).to have_content 'Google'
  end
end
