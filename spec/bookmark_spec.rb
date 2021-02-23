require 'bookmark'

describe Bookmark do
  describe 'all' do
    it 'returns all bookmarks' do

      Bookmark.add_bookmark("http://www.makersacademy.com")
      Bookmark.add_bookmark("http://www.destroyallsoftware.com")
      Bookmark.add_bookmark("http://www.google.com")

      bookmarks = Bookmark.all

      expect(bookmarks).to include('http://www.makersacademy.com')
      expect(bookmarks).to include('http://www.destroyallsoftware.com')
      expect(bookmarks).to include('http://www.google.com')
    end
  end

  describe '#self.add_bookmark' do
    it 'takes the user input and adds it as a new bookmark into the database' do
      Bookmark.add_bookmark("http://www.sushi.com")
      bookmarks = Bookmark.all
      expect(bookmarks).to include('http://www.sushi.com')
    end
  end
end
