feature 'Adding and viewing comments' do
  feature 'a user can add then view a comment' do
    scenario 'when a comment is added for a bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Makers', url: 'http://www.makersacademy.com')

      visit '/bookmarks'
      first('.bookmark').click_button 'Add Comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

      fill_in 'comment', with: 'This is a test comment on this bookmark'
      click_button 'Submit'

      expect(current_path).to eq '/bookmarks'
      expect(first('.bookmark')).to have_content 'This is a test comment on this bookmark'
    end
  end
end
