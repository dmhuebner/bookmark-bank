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
				get :index, topic_id: my_topic.id, bookmark_id: my_bookmark.id
				expect(response).to have_http_status(:success)
			end
			it "renders #index view" do
				get :index, topic_id: my_topic.id, bookmark_id: my_bookmark.id
				expect(response).to render_template(:index)
			end
			it "assigns my_like to @likes" do
				get :index, topic_id: my_topic.id, bookmark_id: my_bookmark.id
				expect(assigns(:likes)).to eq([my_like])
			end
		end

		describe "POST #create" do
			it "increases the number of likes by 1" do
				expect{post :create, topic_id: my_topic.id, bookmark_id: my_bookmark.id, like: {user_id: my_user.id}}.to change(Like, :count).by(1)
			end
			it "assigns Like.last to @like" do
				post :create, topic_id: my_topic.id, bookmark_id: my_bookmark.id, like: {user_id: my_user.id}
				expect(assigns(:like)).to eq(Like.last)
			end
			it "redirects to the bookmark's topic show view" do
				post :create, topic_id: my_topic.id, bookmark_id: my_bookmark.id, like: {user_id: my_user.id}
				expect(response).to redirect_to(my_bookmark.topic)
			end
		end

		describe "DELETE #destroy" do
			it "deletes the like" do
				delete :destroy, topic_id: my_topic.id, bookmark_id: my_bookmark.id, id: my_like.id
				count = Like.where(id: my_like.id).size
				expect(count).to eq(0)
			end
			it "redirects to the bookmark's topic show view" do
				delete :destroy, topic_id: my_topic.id, bookmark_id: my_bookmark.id, id: my_like.id
				expect(response).to redirect_to(my_bookmark.topic)
			end
		end
	end

end
