require 'bookmark'
require 'database_helpers'

describe Bookmark do
  let(:comment_class) { double(:comment_class) }
  let(:tag_class) {double(:tag_class)}
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
      persisted_data = persisted_data(table: 'bookmarks', id: bookmark.id)

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'Sushi'
      expect(bookmark.url).to eq 'http://www.sushi.com'
    end

    it 'does not add a new bookmark if the URL is not valid' do
      Bookmark.add_bookmark(title: 'Sushi', url: 'not a real bookmark')
      expect(Bookmark.all).to be_empty
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

  describe '#update' do
    it 'updates a bookmark with new details' do
      bookmark = Bookmark.add_bookmark(title: 'Cheese', url: 'http://www.cheese.com')

      updated_bookmark = Bookmark.update(id: bookmark.id, title: 'Sushi', url: 'http://www.sushi.com')

      expect(updated_bookmark).to be_a Bookmark
      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'Sushi'
      expect(updated_bookmark.url).to eq 'http://www.sushi.com'
    end
  end

  describe '#find' do
    it 'returns the requested bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Cheese', url: 'http://www.cheese.com')

      result = Bookmark.find(id: bookmark.id)

      expect(result).to be_a Bookmark
      expect(result.id).to eq bookmark.id
      expect(result.title).to eq 'Cheese'
      expect(result.url).to eq 'http://www.cheese.com'
    end
  end

  describe '#comments' do
    it 'returns a list of comments on the bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Makers', url: 'http://www.makersacademy.com')
      expect(comment_class).to receive(:where).with(bookmark.id)

      bookmark.comments(comment_class)
    end
  end

  describe '#tags' do
    it 'returns a list of tags on the bookmark' do
      bookmark = Bookmark.add_bookmark(title: 'Makers Academy', url: 'http://www.makersacademy.com')
      result = DatabaseConnection.query("INSERT INTO tags (content) VALUES('Test tag') RETURNING id;")
      DatabaseConnection.query("INSERT INTO bookmark_tags (bookmark_id, tag_id) VALUES('#{bookmark.id}','#{result[0]['id']}')")
      tag = bookmark.tags.first

      expect(tag['content']).to eq 'Test tag'
    end
  end
end
