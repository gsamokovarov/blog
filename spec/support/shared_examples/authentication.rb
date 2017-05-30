RSpec.shared_examples 'authentication' do |verb, path|
  it "requires authentication" do
    public_send(verb, path, as: :json)

    expect(response.body).to eq_as_json error: 'unauthenticated'
    expect(response).to have_http_status(:unauthorized)
  end
end
