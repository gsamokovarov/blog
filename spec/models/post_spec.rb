require 'rails_helper'

RSpec.describe Post do
  describe '.active' do
    it 'is a post posted at least 2 minutes ago' do
      post = create :post, :active

      expect { travel_to 3.minutes.from_now }.to change { Post.active }.from([]).to [post]
    end

    it 'filters posts with NULL activated_at' do
      create :post

      expect(Post.active).to be_empty
    end
  end
end
