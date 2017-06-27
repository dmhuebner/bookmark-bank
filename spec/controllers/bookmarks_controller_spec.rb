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
				expect(post :create, {bookmark: {url: RandomData.random_url, topic_id: my_topic.id}})
			end
		end

	  # describe "GET #edit" do
	  #   it "returns http success" do
	  #     get :edit
	  #     expect(response).to have_http_status(:success)
	  #   end
	  # end
	end

end
