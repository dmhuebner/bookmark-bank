require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

	# Shoulda relational tests
	it {should have_many(:topics)}

	# Shoulda attribute validattion
	it {should validate_presence_of(:name)}
	it {should validate_length_of(:name).is_at_least(1)}

	it {should validate_presence_of(:email)}
	it {should validate_uniqueness_of(:email)}
	it {should allow_value("user@test.com").for(:email)}

	it {should validate_presence_of(:password)}
	it {should validate_length_of(:password).is_at_least(6)}

	describe "attributes" do
		it "should have name and email attributes" do
			expect(user).to have_attributes(name: user.name, email: user.email)
		end
	end
end
