require 'bookmark'

describe Bookmark do
  describe 'all' do
    it 'returns all bookmarks' do
      bookmarks = Bookmark.all

      expect(bookmarks).to include('http://theguardian.com')
      expect(bookmarks).to include('http://buzzfeed.com')
      expect(bookmarks).to include('http://bbc.com')
    end
  end
end
