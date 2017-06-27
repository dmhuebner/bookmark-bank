require 'rails_helper'

RSpec.describe BookmarksController, type: :controller do
	let(:my_user) {create(:user)}
	let(:my_topic) {create(:topic)}
	let(:my_bookmark) {create(:bookmark)}

	context "signed in user" do
		before do
			my_user.confirm
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

		describe "POST #create" do
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

	  describe "GET #edit" do
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
	end

end
