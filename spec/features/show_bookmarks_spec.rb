feature 'User can see bookmarks' do
  scenario 'see all bookmarks' do

    Bookmark.add_bookmark('http://www.makersacademy.com')
    Bookmark.add_bookmark('http://www.destroyallsoftware.com')
    Bookmark.add_bookmark('http://www.google.com')

    visit '/bookmarks'

    expect(page).to have_content 'http://www.makersacademy.com'
    expect(page).to have_content 'http://www.destroyallsoftware.com'
    expect(page).to have_content 'http://www.google.com'
  end
end
