require 'rails_helper'

RSpec.describe Bookmark, type: :model do
	let(:user) {create(:user)}
	let(:topic) {create(:topic)}

	# Shoulda Relational tests
	it {should belong_to(:topic)}

	# Shoulda Validation tests
	it {should validate_presence_of(:url)}
	it {should validate_presence_of(:topic)}
	it {should validate_length_of(:url).is_at_least(3)}
end
