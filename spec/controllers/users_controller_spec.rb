require 'rails_helper'

RSpec.describe UsersController, type: :controller do
	# Constants
	let(:my_user) {create(:user)}
	let(:other_user) {create(:user)}
	let(:my_topic) {create(:topic, user: my_user)}
	let(:my_bookmark) {create(:bookmark, topic: my_topic, user: my_user)}

	before do
		my_user.confirm
		other_user.confirm
		sign_in my_user
	end

	context "Guest user" do
		describe "GET #show" do
			it "does not return http success" do
				get :show, id: other_user.id
				expect(response).not_to eq(:success)
			end
		end
	end

	context "Signed in user" do

		describe "GET #show" do
			it "returns http success" do
				get :show, id: my_user.id
				expect(response).to have_http_status(:success)
			end
			it "renders the #show view" do
				get :show, id: my_user.id
				expect(response).to render_template(:show)
			end
			it "assigns my_user to @user" do
				get :show, id: my_user.id
				expect(assigns(:user)).to eq(my_user)
			end
		end
		it "assigns my_user.bookmarks to @bookmarks" do
			get :show, id: my_user.id
			expect(assigns(:bookmarks)).to eq(my_user.bookmarks)
		end
		it "assigns my_user.likes to @liked_bookmarks" do
			get :show, id: my_user.id
			expect(assigns(:liked_bookmarks)).to eq(my_user.likes)
		end
	end

end
