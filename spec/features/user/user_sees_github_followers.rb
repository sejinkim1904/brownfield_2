require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    describe 'I should see a seciton for "GitHub"' do
      it "should see list of all followers with their handles linking to their Github profile" do
        user1 = User.create!(
          email: "sejin@gmail.com",
          first_name: "Sejin",
          last_name: "Kim",
          password: "password",
          token: ENV['GITHUB_TOKEN']
        )

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
        json_response1 = File.open("./spec/fixtures/github_followers.json")
        stub_request(:get, "https://api.github.com/user/followers")
          .with(headers: {'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}"})
          .to_return(status: 200, body: json_response1)
        json_response2 = File.open("./spec/fixtures/github_repos.json")
        stub_request(:get, "https://api.github.com/user/repos?sort=updated_at&per_page=5")
          .with(headers: {'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}"})
          .to_return(status: 200, body: json_response2)
        json_response3 = File.open("./spec/fixtures/github_following.json")
        stub_request(:get, "https://api.github.com/user/following")
          .with(headers: {'Authorization' => "Bearer #{ENV['GITHUB_TOKEN']}"})
          .to_return(status: 200, body: json_response3)

        visit dashboard_path

        within ".github" do
          expect(page).to have_content("Followers")
          expect(page).to have_link("renecasco")
          expect(page).to have_link("Loomus")
          expect(page).to have_link("nathangthomas")
          expect(page).to have_link("tayjames")
        end
      end
    end
  end
end
