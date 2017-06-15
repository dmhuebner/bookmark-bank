require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) {create(:user)}

	# Shoulda relational tests

	# Shoulda attribute validattion

	describe "attributes" do
		it "should have name and email attributes" do
			expect(user).to have_attributes(name: user.name, email: user.email)
		end
	end
end
