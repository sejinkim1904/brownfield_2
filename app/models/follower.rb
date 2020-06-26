class Follower
  attr_reader :login, :html_url

  def initialize(follower)
    @login = follower[:login]
    @html_url = follower[:html_url]
  end
end
