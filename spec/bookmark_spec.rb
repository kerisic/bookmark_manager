require 'bookmark'
require 'database_helpers'

describe Bookmark do
  describe 'all' do
    it 'returns all bookmarks' do
      bookmark = Bookmark.add_bookmark(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      Bookmark.add_bookmark(title: 'Destroy All Software', url: 'http://www.destroyallsoftware.com')
      Bookmark.add_bookmark(title: 'Google', url: 'http://www.google.com')

      bookmarks = Bookmark.all

      expect(bookmarks.length).to eq 3
      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.title).to eq 'Makers Academy'
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
    end
  end

  describe '#self.add_bookmark' do
    it 'takes the user input and adds it as a new bookmark into the database' do
      bookmark = Bookmark.add_bookmark(title: 'Sushi', url: 'http://www.sushi.com')
      persisted_data = persisted_data(id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Sushi'
      expect(bookmark.url).to eq 'http://www.sushi.com'
    end
  end

  describe '#title' do
    it 'returns the title' do
      bookmark = Bookmark.add_bookmark(title: 'Cheese', url: 'http://www.cheese.com')
      expect(bookmark.title).to eq 'Cheese'
    end
  end

  describe '#url' do
    it 'returns the url' do
      bookmark = Bookmark.add_bookmark(title: 'Cheese', url: 'http://www.cheese.com')
      expect(bookmark.url).to eq 'http://www.cheese.com'
    end
  end

  describe '#delete' do
    it 'deletes a bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Cheese', url: 'http://www.cheese.com')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end
end
