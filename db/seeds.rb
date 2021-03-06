require 'random_data'

5.times do
	u = User.create!(
		name: RandomData.random_name,
		email: RandomData.random_email,
		password: RandomData.random_sentence
	)
	u.confirm
end

test_user = User.create!(
	name: "Test User",
	email: "test@example.com",
	password: "helloworld"
)
test_user.confirm

# admin = User.create!(
# 	name: "Admin User",
# 	email: "admin@example.com",
# 	password: "helloworld",
# 	role: "admin"
# )

users = User.all

10.times do
	Topic.create!(
		title: RandomData.random_sentence,
		user: users.sample
	)
end
topics = Topic.all

50.times do
	user = users.sample
	bookmark = Bookmark.create!(
		topic: topics.sample,
		user: user,
		name: RandomData.random_name,
		url: RandomData.random_url,
		description: RandomData.random_sentence
	)
	# Create like when bookmarks are created
	bookmark.likes.create!(user_id: user.id)
	bookmark.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end
bookmarks = Bookmark.all

# TODO Implement random Like creation for Users/show view
25.times do
	like = Like.create!(
		user: users.sample,
		bookmark: bookmarks.sample
	)
end
likes = Like.all

# 50.times do
# 	bookmark = Bookmark.create!(
# 		topic: topics.sample,
# 		user: users.sample,
# 		name: RandomData.random_name,
# 		url: RandomData.random_url,
# 		description: RandomData.random_sentence
# 	)
# 	bookmark.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
# end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{test_user.name} #{test_user.email} created"
puts "#{Topic.count} topics created"
puts "#{Bookmark.count} bookmarks created"
puts "#{Like.count} likes created"
