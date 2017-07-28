class BookmarksController < ApplicationController
  def show
		@bookmark = Bookmark.find(params[:id])
  end

  def new
		@topic = Topic.find(params[:topic_id])
		@bookmark = @topic.bookmarks.new
  end

	def create
		@topic = Topic.find(params[:topic_id])
		@bookmark = @topic.bookmarks.build(bookmark_params)

		if @bookmark.save
			flash[:notice] = "\"#{@bookmark.name}\" bookmark was saved successfully!"
			redirect_to @bookmark.topic
		else
			flash[:alert] = "There was an error saving the bookmark. Please try again."
			render :new
		end
	end

  def edit
		@topic = Topic.find(params[:topic_id])
		@bookmark = @topic.bookmarks.find(params[:id])
		# Pundit Authorization
		authorize @bookmark
  end

	def update
		@topic = Topic.find(params[:topic_id])
		@bookmark = @topic.bookmarks.find(params[:id])
		# Pundit Authorization
		authorize @bookmark
		@bookmark.topic = @topic
		@bookmark.assign_attributes(bookmark_params)

		if @bookmark.save
			flash[:notice] = "\"#{@bookmark.name}\" was updated successfully."
			redirect_to @bookmark.topic
		else
			flash[:alert] = "There was an error updating the bookmark. Please try again."
			render :edit
		end
	end

	def destroy
		@topic = Topic.find(params[:topic_id])
		@bookmark = @topic.bookmarks.find(params[:id])
		# Pundit Authorization
		authorize @bookmark

		if @bookmark.destroy
			flash[:notice] = "The \"#{@bookmark.name}\" bookmark was deleted successfully."
			redirect_to @topic
		else
			flash[:alert] = "There was an error deleting the bookmark. Please try again."
			render @topic
		end
	end

	private

	def bookmark_params
		params.require(:bookmark).permit(:name, :url, :description, :topic_id)
	end
end
