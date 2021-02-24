require 'sinatra/base'
require './lib/bookmark'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override

  get '/bookmarks' do
    @list = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmarks/new' do
    Bookmark.add_bookmark(title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
