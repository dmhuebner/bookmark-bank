class TopicsController < ApplicationController
  def index
		@topics = Topic.all
  end

  def show
		@topic = Topic.find(params[:id])
  end

  def new
		@topic = Topic.new
  end

  def edit
		@topic = Topic.find(params[:id])
  end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user

		if @topic.save
			flash[:notice] = "Topic was save successfully."
			redirect_to @topic
		else
			flash[:alert] = "There was an error saving the topic. Please try again."
			render :new
		end
	end

	def update
		@topic = Topic.find(params[:id])
		@topic.assign_attributes(topic_params)

		if @topic.save
			flash[:notice] = "\"#{@topic.title}\" topic was updated successfully"
			redirect_to @topic
		else
			flash[:alert] = "There was an error in saving the changes to the \"#{topic.title}\" topic. Please try again."
			render :edit
		end
	end

	def destroy
		@topic = Topic.find(params[:id])

		if @topic.destroy
			flash[:notice] = "The \"#{@topic.title}\" topic was deleted successfully."
			redirect_to topics_path
		else
			flash[:alert] = "There was an error deleting the \"#{@topic.title}\" topic. Please try again."
			render :index
		end
	end

	private
	def topic_params
		params.require(:topic).permit(:title, :user_id)
	end
end
