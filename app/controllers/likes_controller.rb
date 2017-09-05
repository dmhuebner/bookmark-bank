class LikesController < ApplicationController

  def index
		@bookmark = Bookmark.find(params[:bookmark_id])
		@likes = @bookmark.likes

		authorize @likes
  end

	def create
		@bookmark = Bookmark.friendly.find(params[:bookmark_id])

		@like = @bookmark.likes.build(user_id: current_user.id)
		authorize @like

		if @like.save
			flash[:notice] = "You liked \"#{@bookmark.name}\"!"
			redirect_to [@bookmark.topic]
		else
			flash[:alert] = "There was a problem liking the bookmark. Please try again."
			render [@bookmark.topic]
		end
	end

	def destroy
		@bookmark = Bookmark.friendly.find(params[:bookmark_id])
		@like = @bookmark.likes.find(params[:id])
		authorize @like

		if @like.destroy
			flash[:notice] = "You have unliked \"#{@bookmark.name}\""
			redirect_to [@bookmark.topic]
		else
			flash[:alert] = "There was a problem unliking the bookmark. Please try again."
			render [@bookmark.topic]
		end
	end
end
