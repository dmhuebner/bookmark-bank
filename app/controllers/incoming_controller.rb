class IncomingController < ApplicationController

	# http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
	skip_before_action :verify_authenticity_token, only: [:create]

	def create
		# Take a look at these in your server logs
		# to get a sense of what you're dealing with.
		#puts "INCOMING PARAMS HERE: #{params}"

		# You put the message-splitting and business
		# magic here.

		user = User.find_by_email(params[:sender])
		subject = params[:subject]
		content = params[:'body-plain']
		url = content.scan(/((([A-Za-z]{3,9}:(?:\/\/)?)(?:[-;:&=\+\$,\w]+@)?[A-Za-z0-9.-]+|(?:www.|[-;:&=\+\$,\w]+@)[A-Za-z0-9.-]+)((?:\/[\+~%\/.\w-_]*)?\??(?:[-\+=&;%@.\w_]*)#?(?:[\w]*))?)/)[0][0]

		topics = []

		subject.scan(/\B#([^,\#]+)/).each do |topic|
			topics.push(Topic.find_or_create_by(title: topic))
		end

		bookmark = user.bookmarks.create(url: url)

		if bookmark.save
			topics.each do |topic|
        Topic.create(bookmark_id: bookmark.id, topic_id: topic.id)
      end
			# Assuming all went well.
			head 200
		else
			head :no_content
		end
	end
end
