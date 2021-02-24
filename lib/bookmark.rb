require 'pg'

class Bookmark
  attr_reader :title, :url, :id

  def self.all
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    # make a connection to db and return all data, then save it into result
    result = connection.exec("SELECT * FROM bookmarks;")

    # as data will be returned in rows as each element in an array
    # map it so that each attribute gets passed into new's arguments, to create a Bookmark object
    result.map do |bookmark|
      Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url'])
    end
  end

  def self.add_bookmark(title:, url:)
    if ENV['ENVIRONMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    #connect and insert bookmark values into table, at the sametime, return id, title and url which is saved in result
    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES ('#{url}', '#{title}') RETURNING id, title, url;")
    #create new Bookmark object using id, title and url in the array's first element
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
  end

  def initialize(id:, title:, url:)
    @id = id
    @title = title
    @url = url
  end
end
