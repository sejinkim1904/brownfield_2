require 'rails_helper'

describe 'As a user' do
  describe 'When I visit /dashboard' do
    describe 'I should see a seciton for "GitHub"' do
      it "should see a list of 5 repositories with the name of each Repo linking to the repo on Github" do
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
          expect(page).to have_content("GitHub")
          expect(page).to have_link("brownfield_2")
          expect(page).to have_link("m3_exercises")
          expect(page).to have_link("mastermind")
          expect(page).to have_link("credit_check")
          expect(page).to have_link("php_practice")
        end
      end

      it "should not show repos if the user does not have a token" do
        user2 = User.create!(
          email: "marheem@gmail.com",
          first_name: "Marheem",
          last_name: "Kim",
          password: "password",
        )
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)

        visit dashboard_path

        expect(page).to_not have_content("Github")
      end
    end
  end
end
