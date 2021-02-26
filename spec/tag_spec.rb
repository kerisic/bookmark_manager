require 'tag'

describe Tag do
  it 'can create a new tag' do
    tag = Tag.create(content: 'Test')

    persisted_data = persisted_data(table: 'tags', id: tag.id)

    expect(tag).to be_a Tag
    expect(tag.id).to eq persisted_data.first['id']
    expect(tag.content).to eq 'Test'
  end

  describe '.find' do
    it 'can find a tag given its id' do
      tag = Tag.create(content: 'testing')

      result = Tag.find(id: tag.id)

      expect(result.id).to eq tag.id
      expect(result.content).to eq tag.content
    end
  end

  describe '.where' do
    it 'returns tags linked to the given bookmark id' do
      bookmark = Bookmark.add_bookmark(url: "http://www.makersacademy.com", title: 'Makers')
      tag1 = Tag.create(content: 'test tag 1')
       tag2 = Tag.create(content: 'test tag 2')
       BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag1.id)
       BookmarkTag.create(bookmark_id: bookmark.id, tag_id: tag2.id)
       tags = Tag.where(bookmark_id: bookmark.id)
       tag = tags.first
       expect(tags.length).to eq 2
       expect(tag).to be_a Tag
       expect(tag.id).to eq tag1.id
       expect(tag.content).to eq tag1.content
    end
  end
end
