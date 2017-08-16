class UsersController < ApplicationController
  def show
		@user = User.friendly.find(current_user.id)
		@bookmarks = @user.bookmarks

		@liked_bookmarks = []

		@user.likes.each {|l| @liked_bookmarks.push(l.bookmark)}

		@topics = []
		@liked_bookmark_topics = []

		topics_of_bookmarks(@liked_bookmark_topics, @liked_bookmarks)
		topics_of_bookmarks(@topics, @bookmarks)

		# Pundit Authorization
		authorize User
  end

	private
	def topics_of_bookmarks(topics, bookmarks)
		bookmarks.each do |b|
			if !topics.include?(b.topic)
				topics.push(b.topic)
			end
		end
	end
end
