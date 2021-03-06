require 'pg'
require 'uri'
require_relative 'databaseconnection'
require_relative './comment'
require_relative './tag'

class Bookmark
  attr_reader :title, :url, :id

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end

  def self.all
    # make a connection to db and return all data, then save it into result
    result = DatabaseConnection.query('SELECT * FROM bookmarks;')

    # as data will be returned in rows as each element in an array
    # map it so that each attribute gets passed into new's arguments, to create a Bookmark object
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.add_bookmark(title:, url:)
    return false unless is_url?(url)

    # connect and insert bookmark values into table, at the sametime, return id, title and url which is saved in result
    result = DatabaseConnection.query("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
    # create new Bookmark object using id, title and url in the array's first element
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.delete(id:)
    DatabaseConnection.query("DELETE FROM bookmarks WHERE id = #{id}")
  end

  def self.update(id:, title:, url:)
    result = DatabaseConnection.query("UPDATE bookmarks SET url = '#{url}', title = '#{title}' WHERE id = #{id} RETURNING id, url, title;")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.find(id:)
    result = DatabaseConnection.query("SELECT * FROM bookmarks WHERE id = #{id};")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def self.where(tag_id:)
    result = DatabaseConnection.query("SELECT bookmarks.id, title, url FROM bookmark_tags INNER JOIN bookmarks ON bookmarks.id = bookmark_tags.bookmark_id WHERE bookmark_tags.tag_id = '#{tag_id}';")
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def comments(comment_class = Comment)
    comment_class.where(id)
  end

  def tags(tag_class = Tag)
    tag_class.where(bookmark_id: id)
  end

  def self.is_url?(url)
    url =~ /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/
  end
end
