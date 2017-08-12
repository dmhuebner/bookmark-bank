require 'rails_helper'

RSpec.describe Like, type: :model do
	# Constants - FactoryGirl
	let(:user) {create(:user)}
	let(:topic) {create(:topic)}
	let(:bookmark) {create(:bookmark)}
	let(:like) {create(:like, bookmark: bookmark, user: user)}

	# Shoulda relational tests
	it {should belong_to(:user)}
	it {should belong_to(:bookmark)}

	# Shoulda validation tests
	it {should validate_presence_of(:user)}
	it {should validate_presence_of(:bookmark)}
end
