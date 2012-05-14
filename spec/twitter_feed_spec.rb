require "spec_helper"

describe TwitterFeed do
  include Rack::Test::Methods

  def app
    TwitterFeed
  end

  let(:tweets) do
    [
      mock(:tweet, :full_text => "This is a tweets", :profile_image_url => "http://somewhere.com/image.png")
    ]
  end

  describe "searching tweets via a hash tag" do
    it "should perform search with default tag of #aws" do
      Twitter.should_receive(:search).with("#aws").and_return(tweets)

      get "/"
    end

    it "should perform search with supplied hash tag" do
      Twitter.should_receive(:search).with("#awesome").and_return(tweets)

      get "/?hash_tag=awesome"
    end
  end
end