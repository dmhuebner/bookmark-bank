require 'rails_helper'

RSpec.describe Topic, type: :model do
	let(:user) {create(:user)}
  let(:topic) {create(:topic)}

	# Shoulda relational tests
	it {should belong_to(:user)}

	# Shoulda validation tests
	it {should validate_presence_of(:title)}
	it {should validate_presence_of(:user)}

	it {should validate_length_of(:title).is_at_least(2)}
	it {should validate_length_of(:title).is_at_most(200)}

	describe "attributes" do
		it "has title and user attributes" do
			expect(topic).to have_attributes(title: topic.title, user: topic.user)
		end
	end
end
