require 'rails_helper'

RSpec.describe LikesController, type: :controller do
	# Constants - FactoryGirl
	let(:my_user) {create(:user)}
	let(:my_topic) {create(:topic, user: my_user)}
	let(:my_bookmark) {create(:bookmark, topic: my_topic, user: my_user)}
	let(:my_like) {create(:like, bookmark: my_bookmark, user: my_user)}

	# Confirm test users
	before do
		my_user.confirm
	end

	# TODO add context for guest user

	context "Signed in user" do
		before do
			sign_in my_user
		end

		describe "GET #index" do
			it "returns http success" do
				get :index, bookmark_id: my_bookmark.id
				expect(response).to have_http_status(:success)
			end
			it "renders #index view" do
				get :index, bookmark_id: my_bookmark.id
				expect(response).to render_template(:index)
			end
			it "assigns my_like to @likes" do
				get :index
				expect(assigns(:likes)).to eq([my_like])
			end
		end

		describe "POST #create" do
			it "increases the number of likes by 1" do
				expect{post :create, bookmark_id: my_bookmark.id, like: {user_id: my_user.id}}.to change(Like, :count).by(1)
			end
			it "assigns Like.last to @like" do
				post :create, {like: {user_id: my_user.id, bookmark_id: my_bookmark.id}}
				expect(assigns(:like)).to eq(Like.last)
			end
		end

		describe "DELETE #destroy" do
			# TODO delete action tests
		end
	end

end
