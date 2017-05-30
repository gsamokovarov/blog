require 'rails_helper'

RSpec.describe PostsController, type: :request do
  context "GET /posts" do
    include_examples 'authentication', :get, '/posts'

    it "renders the posts for the current user" do
      user = create :user
      post = create :post, user: user

      # create a post from another user and don't expect it in the results.
      create :post

      get posts_path, headers: auth(user), as: :json

      expect(response.body).to eq_as_json(
        data: [
          id: post.id.to_s,
          type: 'posts',
          attributes: {
            description: post.description,
            active: !!post.activated_at
          },
        ],
        links: {}
      )
    end
  end

  context "GET /post/:id" do
    include_examples 'authentication', :get, '/posts/1'

    it "shows a single post from a user" do
      post = create :post

      get post_path(post), headers: auth(post.user), as: :json

      expect(response.body).to eq_as_json(
        data: {
          id: post.id.to_s,
          type: 'posts',
          attributes: {
            description: post.description,
            active: !!post.activated_at
          },
        }
      )
    end
  end

  context "POST /posts" do
    include_examples 'authentication', :post, '/posts'

    it "creates a post for the current user" do
      user = create :user
      params = { title: 'foo', description: 'bar' }

      expect {
        post posts_path, params: params, headers: auth(user), as: :json
      }.to change { Post.count }

      post = Post.last

      expect(response.body).to eq_as_json(
        data: {
          id: post.id.to_s,
          type: 'posts',
          attributes: {
            description: post.description,
            active: !!post.activated_at
          },
        }
      )
    end

    it "cannot create a post without a title" do
      user = create :user
      params = { description: 'bar' }

      post posts_path, params: params, headers: auth(user), as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq_as_json(
        errors: {
          title: ["can't be blank"]
        }
      )
    end

    it "cannot create a post without a description" do
      user = create :user
      params = { title: 'bar' }

      post posts_path, params: params, headers: auth(user), as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq_as_json(
        errors: {
          description: ["can't be blank"]
        }
      )
    end
  end

  context "PATCH /posts/:id" do
    include_examples 'authentication', :patch, '/posts/1'

    it "updates a post for the current user" do
      post = create :post
      params = { description: 'changed' }

      expect {
        patch post_path(post), params: params, headers: auth(post.user), as: :json
        post.reload
      }.to change { post.description }

      expect(response).to have_http_status(:no_content)
    end

    it "cannot update a post with blank title" do
      post = create :post
      params = { title: '' }

      patch post_path(post), params: params, headers: auth(post.user), as: :json

      expect(response).to have_http_status(:unprocessable_entity)
      expect(response.body).to eq_as_json(
        errors: {
          title: ["can't be blank"]
        }
      )
    end
  end

  context "DELETE /posts/:id" do
    include_examples 'authentication', :delete, '/posts/1'

    it "deletes a post from the current user" do
      post = create :post

      expect {
        delete post_path(post), headers: auth(post.user), as: :json
      }.to change { Post.count }.by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end
end
