require 'rails_helper'

describe "An Admin can edit a tutorial" do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  scenario "by adding a video", :js do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    response = File.open("./spec/fixtures/youtube.json")
    stub_request(:get, "https://www.googleapis.com/youtube/v3/videos?id=J7ikFUlkP_k&key=#{ENV['YOUTUBE_API_KEY']}&part=snippet,contentDetails,statistics")
      .to_return(status: 200, body: response)

    stub_request(:get, "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_83.0.4103").
      with(
        headers: {
     	    'Accept'=>'*/*',
     	    'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
     	    'Host'=>'chromedriver.storage.googleapis.com',
     	    'User-Agent'=>'Ruby'
        }
      ).
        to_return(status: 200, body: "", headers: {})

    visit edit_admin_tutorial_path(tutorial)

    click_on "Add Video"

    fill_in "video[title]", with: "How to tie your shoes."
    fill_in "video[description]", with: "Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through."
    fill_in "video[video_id]", with: "J7ikFUlkP_k"
    click_on "Create Video"

    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

    within(first(".video")) do
      expect(page).to have_content("How to tie your shoes.")
    end
  end
end
