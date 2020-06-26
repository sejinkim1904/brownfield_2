class GithubService
  def repos_by_updated_at(token)
    get_json("/user/repos?sort=updated_at&per_page=5", token)
  end

  def followers(token)
    get_json("/user/followers", token)
  end

  private

  def conn(token)
    Faraday.new(url: "https://api.github.com") do |f|
      f.authorization :Bearer, token
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url, token)
    response = conn(token).get(url)
    JSON.parse(response.body, symbolize_names: true)
  end
end
