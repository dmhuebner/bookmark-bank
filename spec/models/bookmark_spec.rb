require 'rails_helper'

RSpec.describe Bookmark, type: :model do
	let(:user) {create(:user)}
	let(:topic) {create(:topic)}
	let(:bookmark) {create(:bookmark)}

	# Shoulda Relational tests
	it {should belong_to(:topic)}
	it {should belong_to(:user)}

	# Shoulda Validation tests
	it {should validate_presence_of(:url)}
	it {should validate_presence_of(:topic)}
	it {should validate_presence_of(:user)}
	it {should validate_presence_of(:name)}
	# description attribute optional
	# it {should validate_presence_of(:description)}

	it {should validate_length_of(:url).is_at_least(3)}
	it {should validate_length_of(:name).is_at_least(1)}
	it {should validate_length_of(:description).is_at_most(100)}

	describe "attributes" do
		it "has url and description attributes" do
			expect(bookmark).to have_attributes(url: bookmark.url, description: bookmark.description, name: bookmark.name)
		end
	end
end
