require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base

get '/' do
  'Hello'
end

get '/bookmarks' do
  @list = Bookmark.all
  erb :index
end

run! if app_file == $0

end
