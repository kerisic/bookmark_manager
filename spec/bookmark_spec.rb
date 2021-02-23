require 'bookmark'

describe Bookmark do
  describe 'all' do
    it 'returns all bookmarks' do

      Bookmark.add_bookmark('Makers', "http://www.makersacademy.com")
      Bookmark.add_bookmark('Destroy', "http://www.destroyallsoftware.com")
      Bookmark.add_bookmark('Google', "http://www.google.com")

      bookmarks = Bookmark.all.map(&:title)

      expect(bookmarks).to include('Makers')
      expect(bookmarks).to include('Destroy')
      expect(bookmarks).to include('Google')
    end
  end

  describe '#self.add_bookmark' do
    it 'takes the user input and adds it as a new bookmark into the database' do
      Bookmark.add_bookmark('Sushi', "http://www.sushi.com")
      bookmarks = Bookmark.all.map(&:title)
      expect(bookmarks).to include('Sushi')
    end
  end

  describe '#title' do
    it 'returns the title' do
      bookmark = Bookmark.new('Cheese', 'http://www.cheese.com')
      expect(bookmark.title).to eq 'Cheese'
    end
  end

  describe '#url' do
    it 'returns the url' do
      bookmark = Bookmark.new('Cheese', 'http://www.cheese.com')
      expect(bookmark.url).to eq 'http://www.cheese.com'
    end
  end
end
