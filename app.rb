require 'sinatra/base'
require 'sinatra/flash'
require 'uri'
require_relative './lib/bookmark'
require_relative './lib/comment'
require_relative './lib/tag'
require_relative './lib/bookmarktag'
require_relative './database_connection_setup'

class BookmarkManager < Sinatra::Base
  enable :sessions, :method_override
  register Sinatra::Flash

  get '/bookmarks' do
    @list = Bookmark.all
    erb :'bookmarks/index'
  end

  post '/bookmarks' do
    flash[:notice] = 'You must submit a valid URL.' unless Bookmark.add_bookmark(title: params[:title],
                                                                                 url: params['url'])
    redirect '/bookmarks'
  end

  delete '/bookmarks/:id' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/edit' do
    @bookmark = Bookmark.find(id: params[:id])
    erb :'bookmarks/edit'
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], title: params[:title], url: params[:url])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb :'comments/new'
  end

  post '/bookmarks/:id/comments' do
    Comment.create(text: params[:comment], bookmark_id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/tags/new' do
    @bookmark_id = params[:id]
    erb :'tags/new'
  end

  post '/bookmarks/:id/tags' do
    tag = Tag.create(content: params[:tag])
    BookmarkTag.create(bookmark_id: params[:id], tag_id: tag.id)
    redirect '/bookmarks'
  end

  get '/tags/:id/bookmarks' do
    @tag = Tag.find(id: params[:id])
    erb :'tags/index'
  end

  run! if app_file == $0
end
