feature 'Add and view tags' do
  feature 'User can add and view bookmarks by tags' do
    scenario 'when a comment is added for a bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Makers', url: 'http://www.makersacademy.com')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Tag'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/tags/new"

      fill_in 'tag', with: 'Awesome'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'Awesome'
    end
  end
end
