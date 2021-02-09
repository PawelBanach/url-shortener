require 'rails_helper'

describe Url, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of :source }
    it { is_expected.to validate_uniqueness_of :key }
    it { is_expected.to allow_value("http://www.example.com").for(:source) }
    it { is_expected.to allow_value("http://example.com").for(:source) }
    it { is_expected.to allow_value("https://www.example.com").for(:source) }
    it { is_expected.to_not allow_value("www.example.com").for(:source) }
    it { is_expected.to_not allow_value("httpexample.com").for(:source) }
    it { is_expected.to_not allow_value("test").for(:source) }
  end

  describe "#generate_key" do
    subject { Url.new(source: "http://www.example.com") }

    context "when key not set" do
      it "generates key" do
        subject.save

        expect(subject.key).to be_present
      end
    end
  end

  describe "#redirect_url" do
    subject { Url.new(source: "http://www.example.com", key: "short") }

    it "returns redirect url" do
      expect(subject.redirect_url).to eq("")
    end
  end
end
