require 'rails_helper'

describe Following do
  it "exists" do
    attrs = {
      login: "marheem",
      html_url: "https://github.com/marheem"
    }

    following = Following.new(attrs)

    expect(following).to be_a Following
    expect(following.login).to eq(attrs[:login])
    expect(following.html_url).to eq(attrs[:html_url])
  end
end
