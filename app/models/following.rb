class Following
  attr_reader :login, :html_url

  def initialize(following)
    @login = following[:login]
    @html_url = following[:html_url]
  end
end
