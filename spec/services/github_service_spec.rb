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
    end
  end
end
