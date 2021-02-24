feature 'User can see bookmarks' do
  scenario 'see all bookmarks' do
    Bookmark.add_bookmark(title: 'Makers', url: 'http://www.makersacademy.com')
    Bookmark.add_bookmark(title: 'Destroy', url: 'http://www.destroyallsoftware.com')
    Bookmark.add_bookmark(title: 'Google', url: 'http://www.google.com')

    visit '/bookmarks'

    expect(page).to have_link('Makers', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Destroy', href: 'http://www.destroyallsoftware.com')
    expect(page).to have_link('Google', href: 'http://www.google.com')
  end
end
