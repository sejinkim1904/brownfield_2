require 'rails_helper'
require 'webmock/rspec'

describe GithubService do
  context "instance methods" do
    context "#repos_by_updated_at" do
      it "returns repo data" do
        json_response = File.open("./spec/fixtures/github_repos.json")
        stub_request(:get, "https://api.github.com/user/repos?sort=updated_at&per_page=5")
          .with(headers: {'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}"})
          .to_return(status: 200, body: json_response)
        repos = subject.repos_by_updated_at(ENV['GITHUB_TOKEN'])

        expect(repos).to be_a Array
        expect(repos[0]).to be_a Hash
        expect(repos.count).to eq 5
        repo_data = repos.first

        expect(repo_data).to have_key :name
        expect(repo_data).to have_key :html_url
      end

      it "returns followers data" do
        json_response = File.open("./spec/fixtures/github_followers.json")
        stub_request(:get, "https://api.github.com/user/followers")
          .with(headers: {'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}"})
          .to_return(status: 200, body: json_response)

        followers = subject.followers(ENV['GITHUB_TOKEN'])

        expect(followers).to be_a Array
        expect(followers[0]).to be_a Hash
        expect(followers.count).to eq 4
        follower_data = followers.first

        expect(follower_data).to have_key :login
        expect(follower_data).to have_key :html_url
      end

      it "returns following data" do
        json_response = File.open("./spec/fixtures/github_following.json")
        stub_request(:get, "https://api.github.com/user/following")
          .with(headers: {'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}"})
          .to_return(status: 200, body: json_response)

        followings = subject.followings(ENV['GITHUB_TOKEN'])

        expect(followings).to be_a Array
        expect(followings[0]).to be_a Hash
        expect(followings.count).to eq 1
        following_data = followings.first

        expect(following_data).to have_key :login
        expect(following_data).to have_key :html_url
      end
    end
  end
end
