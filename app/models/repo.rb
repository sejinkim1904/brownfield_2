class Repo
  attr_reader :name, :html_url
  
  def initialize(repo)
    @name = repo[:name]
    @html_url = repo[:html_url]
  end
end
