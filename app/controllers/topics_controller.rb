class TopicsController < ApplicationController
  def index
		@topics = Topic.all
  end

  def show
		@topic = Topic.friendly.find(params[:id])
  end

  def new
		@topic = Topic.new
		# Pundit Authorization
		authorize @topic
  end

  def edit
		@topic = Topic.friendly.find(params[:id])
		# Pundit Authorization
		authorize @topic
  end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user

		# Pundit Authorization
		authorize @topic

		if @topic.save
			flash[:notice] = "Topic was saved successfully."
			redirect_to @topic
		else
			flash[:alert] = "There was an error saving the topic. Please try again."
			render :new
		end
	end

	def update
		@topic = Topic.friendly.find(params[:id])
		# Pundit Authorization
		authorize @topic
		@topic.assign_attributes(topic_params)

		# FriendlyId will recreate slug if nil
		@topic.slug = nil

		if @topic.save
			flash[:notice] = "\"#{@topic.title}\" topic was updated successfully"
			redirect_to @topic
		else
			flash[:alert] = "There was an error in saving the changes to the \"#{topic.title}\" topic. Please try again."
			render :edit
		end
	end

	def destroy
		@topic = Topic.friendly.find(params[:id])
		# Pundit Authorization
		authorize @topic

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
		params.require(:topic).permit(:title, :user_id, :image)
	end

	def topics_of_bookmarks(topics, bookmarks)
		bookmarks.each do |b|
			if !topics.include?(b.topic)
				topics.push(b.topic)
			end
		end
	end
end
