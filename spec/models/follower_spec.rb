require 'rails_helper'

describe Follower do
  it "exists" do
    attrs = {
      login: 'wedge',
      html_url: 'http://github.com/wedge'
    }

    follower = Follower.new(attrs)

    expect(follower).to be_a Follower
    expect(follower.login).to eq(attrs[:login])
    expect(follower.html_url).to eq(attrs[:html_url])
  end
end
