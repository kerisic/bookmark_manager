feature 'Updating a bookmark' do
  scenario 'User can update a bookmark' do
    bookmark = Bookmark.add_bookmark(title: 'Makers', url: 'http://www.makersacademy.com')
    visit('/bookmarks')
    expect(page).to have_link('Makers', href: 'http://www.makersacademy.com')

    first('.bookmark').click_button 'Edit'
    expect(current_path).to eq "/bookmarks/#{bookmark.id}/edit"

    fill_in('url', with: 'http://www.umbrellaacademy.com')
    fill_in('title', with: 'Umbrella Academy')
    click_button('Submit')

    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_link('Makers', href: 'http://www.makersacademy.com')
    expect(page).to have_link('Umbrella Academy', href: 'http://www.umbrellaacademy.com')
  end
end
