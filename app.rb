require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  get '/bookmarks' do
    @list = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmarks/new' do
    title, url = params.values
    Bookmark.add_bookmark(title, url)
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
