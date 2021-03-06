class IncomingController < ApplicationController

	# http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
	skip_before_action :verify_authenticity_token
	skip_before_action :authenticate_user!

	def create
		#puts "INCOMING PARAMS HERE: #{params}"

		# Message parsing and business magic here.


		@user = User.find_by(email: params[:sender])
    @topic = Topic.find_by(title: params[:subject])
		content = params["body-plain"]
		# Extracts URL from content
    @url = content.scan(/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/)[0][0]
		# Extracts URL name from content
		raw_name = content.scan(/name:.*/i)[0]
		@name = raw_name.slice(5, raw_name.length)

		@name = @name.slice(1, @name.length) if @name[0] == ' '

    if @user.nil?
      @user = User.new(email: params[:sender], password: "t3mp_p@ss", name: "New User")
      @user.skip_confirmation!
      @user.save!
    end

    if @topic.nil?
      @topic = @user.topics.create(title: params[:subject])
    end

    @bookmark = @topic.bookmarks.create(url: @url, name: @name, description: "Enter a description", user: @user)
		# Like newly created bookmark
		@like = @bookmark.likes.create(user: @user)

    head 200



		# bookmark = Bookmark.create(name: RandomData.random_word, description: RandomData.random_paragraph, topic_id: 1, url: "http://google.com")
		#
		# if bookmark.saved
		# 	head 200
		# else
		# 	head :no_content
		# end




		# @user = User.find_by_email(params[:sender])
		# subject = params[:subject]
		# content = params[:'body-plain']
		# url = content.scan(/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/)[0][0]
		#
		# topics = []
		#
		# subject.scan(/\B#([^,\#]+)/).each do |topic|
		# 	topics.push(Topic.find_or_create_by(title: topic))
		# end
		#
		# bookmark = user.bookmarks.build(url: url)
		#
		# if bookmark.save
		# 	topics.each do |topic|
    #     Topic.create(bookmark_id: bookmark.id, topic_id: topic.id)
    #   end
		# 	head 200
		# else
		# 	head :no_content
		# end
	end
end
