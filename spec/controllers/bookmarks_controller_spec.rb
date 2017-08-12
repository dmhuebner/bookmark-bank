require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
	let(:my_user) {create(:user)}
	let(:my_topic) {create(:topic, user: my_user)}
	let(:my_bookmark) {create(:bookmark, topic: my_topic, user: my_user)}

	let(:other_user) {create(:user)}
	let(:other_topic) {create(:topic, user: other_user)}
	let(:other_bookmark) {create(:bookmark, topic: my_topic, user: other_user)}

	# Confirm test users
	before do
		my_user.confirm
		other_user.confirm
	end

	# TODO create context for guest user

	context "signed in user" do
		before do
			sign_in my_user
		end

		describe "GET #show" do
	    it "returns http success" do
	      get :show, topic_id: my_topic.id, id: my_bookmark.id
	      expect(response).to have_http_status(:success)
	    end
			it "renders the #show view" do
				get :show, topic_id: my_topic.id, id: my_bookmark.id
				expect(response).to render_template :show
			end
			it "assigns my_bookmark to @bookmark" do
				get :show, topic_id: my_topic.id, id: my_bookmark.id
				expect(assigns(:bookmark)).to eq(my_bookmark)
			end
	  end

	  describe "GET #new" do
	    it "returns http success" do
	      get :new, topic_id: my_topic.id
	      expect(response).to have_http_status(:success)
	    end
			it "renders the #new view" do
				get :new, topic_id: my_topic.id
				expect(response).to render_template :new
			end
			it "instantiates @bookmark" do
				get :new, topic_id: my_topic.id
				expect(assigns(:bookmark)).not_to be_nil
			end
	  end

		describe "POST #create bookmark under my_topic" do
			it "increases the number of bookmarks by 1" do
				expect{post :create, topic_id: my_topic.id, bookmark: {url: RandomData.random_url, description: RandomData.random_sentence, name: RandomData.random_word, topic_id: my_topic.id}}.to change(Bookmark, :count).by(1)
			end
			it "assigns Bookmark.last to @bookmark" do
				post :create, topic_id: my_topic.id, bookmark: {name: RandomData.random_word, url: RandomData.random_url, description: RandomData.random_sentence, topic_id: my_topic.id}
				expect(assigns(:bookmark)).to eq(Bookmark.last)
			end
			it "redirects to the bookmarks topic show view" do
				post :create, topic_id: my_topic.id, bookmark: {name: RandomData.random_word, url: RandomData.random_url, description: RandomData.random_sentence, topic_id: my_topic.id}
				expect(response).to redirect_to(Bookmark.last.topic)
			end
		end

		describe "POST #create bookmark under other_topic" do
			it "increases the number of bookmarks by 1" do
				expect{post :create, topic_id: other_topic.id, bookmark: {url: RandomData.random_url, description: RandomData.random_sentence, name: RandomData.random_word, topic_id: my_topic.id}}.to change(Bookmark, :count).by(1)
			end
			it "assigns Bookmark.last to @bookmark" do
				post :create, topic_id: other_topic.id, bookmark: {name: RandomData.random_word, url: RandomData.random_url, description: RandomData.random_sentence, topic_id: my_topic.id}
				expect(assigns(:bookmark)).to eq(Bookmark.last)
			end
			it "redirects to the bookmarks topic show view" do
				post :create, topic_id: other_topic.id, bookmark: {name: RandomData.random_word, url: RandomData.random_url, description: RandomData.random_sentence, topic_id: my_topic.id}
				expect(response).to redirect_to(Bookmark.last.topic)
			end
		end

	  describe "GET #edit my_bookmark" do
	    it "returns http success" do
				get :edit, topic_id: my_topic.id, id: my_bookmark.id
	      expect(response).to have_http_status(:success)
	    end
			it "renders the #edit view" do
				get :edit, topic_id: my_topic.id, id: my_bookmark.id
				expect(response).to render_template :edit
			end
			it "assigns the bookmark to be updated to @bookmark" do
				get :edit, topic_id: my_topic.id, id: my_bookmark.id
				bookmark_instance = assigns(:bookmark)
				expect(bookmark_instance.id).to eq(my_bookmark.id)
				expect(bookmark_instance.name).to eq(my_bookmark.name)
				expect(bookmark_instance.description).to eq(my_bookmark.description)
				expect(bookmark_instance.topic).to eq(my_bookmark.topic)
			end
	  end

		describe "GET #edit other_bookmark" do
			it "returns http redirect" do
				get :edit, topic_id: my_topic.id, id: other_bookmark.id
				expect(response).to have_http_status(:redirect)
			end
			it "does not renders the #edit view" do
				get :edit, topic_id: my_topic.id, id: other_bookmark.id
				expect(response).not_to render_template :edit
			end
		end

		describe "PUT #update my_bookmark" do
			it "updates post with expected attributes" do
				new_name = RandomData.random_word
				new_url = RandomData.random_url
				new_description = RandomData.random_sentence
				put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {name: new_name, url: new_url, description: new_description}
				updated_bookmark = assigns(:bookmark)
				expect(updated_bookmark.id).to eq(my_bookmark.id)
				expect(updated_bookmark.name).to eq(new_name)
				expect(updated_bookmark.url).to eq(new_url)
				expect(updated_bookmark.description).to eq(new_description)
			end
			it "redirects to the topic show view of the updated bookmark" do
				new_name = RandomData.random_word
				new_url = RandomData.random_url
				new_description = RandomData.random_sentence
				put :update, topic_id: my_topic.id, id: my_bookmark.id, bookmark: {name: new_name, url: new_url, description: new_description}
				expect(response).to redirect_to my_topic
			end
		end

		describe "PUT #update other_bookmark" do
			it "Does not update post with new attributes" do
				new_name = RandomData.random_word
				new_url = RandomData.random_url
				new_description = RandomData.random_sentence
				put :update, topic_id: my_topic.id, id: other_bookmark.id, bookmark: {name: new_name, url: new_url, description: new_description}
				updated_bookmark = assigns(:bookmark)
				expect(updated_bookmark.id).to eq(other_bookmark.id)
				expect(updated_bookmark.name).to eq(other_bookmark.name)
				expect(updated_bookmark.url).to eq(other_bookmark.url)
				expect(updated_bookmark.description).to eq(other_bookmark.description)
			end
			it "does not return http sucess" do
				new_name = RandomData.random_word
				new_url = RandomData.random_url
				new_description = RandomData.random_sentence
				put :update, topic_id: my_topic.id, id: other_bookmark.id, bookmark: {name: new_name, url: new_url, description: new_description}
				expect(response).not_to eq(:success)
			end
		end

		describe "DELETE #destroy" do
			it "deletes the bookmark" do
				delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
				count = Bookmark.where(id: my_bookmark.id).size
				expect(count).to eq(0)
			end
			it "redirects to the topic's show view" do
				delete :destroy, topic_id: my_topic.id, id: my_bookmark.id
				expect(response).to redirect_to my_topic
			end
		end
	end

end
