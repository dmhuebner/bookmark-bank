class BookmarksController < ApplicationController
  def show
		@bookmark = Bookmark.find(params[:id])
  end

  def new
		@topic = Topic.find(params[:topic_id])
		@bookmark = Bookmark.new
  end

  def edit
  end
end
