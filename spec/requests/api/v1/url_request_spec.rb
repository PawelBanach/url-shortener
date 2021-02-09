require 'rails_helper'

describe "Urls", type: :request do
  describe "#redirect" do
    context "when url present" do
      let(:url) { create(:url) }

      it "redirects" do
        expect(
          get url.redirect_url
        ).to redirect_to(url.source)
      end

      it "increments clicked counter" do
        expect {
          get url.redirect_url
        }.to change { url.reload.clicked }.by(1)
      end
    end

    context "without url in db" do
      let(:url) { build(:url) }

      it "renders not found" do
        get url.redirect_url
        expect(response.status).to eq(404)
      end
    end
  end

  describe "#shorten" do
    context "with taken custom key for same url" do
      let!(:url) { create(:url, source: "https://www.example.com", key: "my_custom_key") }

      it "returns existing url" do
        expect {
          post '/shorten', params: { url: { source: url.source, custom_key: url.key } }
        }.not_to change {Url.count}

        expect(JSON.parse(response.body)).to eq({ "url" => url.redirect_url })
      end
    end

    context "with taken custom key for other url" do
      let!(:url) { create(:url, source: "https://www.example.com", key: "my_custom_key") }
      let(:other_url) { "https://www.other.com" }

      it "returns existing url" do
        post '/shorten', params: { url: { source: other_url, custom_key: url.key } }

        expect(JSON.parse(response.body)).to eq({"errors" => { "key" => ["Key already taken!"] }})
      end
    end

    context "with custom key" do
      it "returns shorten url" do
        post '/shorten', params: { url: { source: "https://www.example.com", custom_key: "short" } }

        expect(JSON.parse(response.body)["url"]).to match(/http:\/\/localhost:3000\/short/)
      end
    end

    context "without custom key" do
      it "returns shorten url" do
        post '/shorten', params: { url: { source: "https://www.example.com" } }

        expect(JSON.parse(response.body)["url"]).to match(/http:\/\/localhost:3000\//)
      end
    end
  end
end
