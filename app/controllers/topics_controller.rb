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

	private
	def topic_params
		params.require(:topic).permit(:title, :user_id)
	end
end
