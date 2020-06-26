class Github
  def initialize(token)
    @token = token
  end

  def repos
    user_repos(@token).map do |repo|
      Repo.new(repo)
    end
  end

  def followers
    user_followers(@token).map do |follower|
      Follower.new(follower)
    end
  end

  def followings
    user_followings(@token).map do |following|
      Following.new(following)
    end
  end

  private

  def user_repos(token)
    @_user_repos ||= service.repos_by_updated_at(token)
  end

  def user_followers(token)
    @_user_followers ||= service.followers(token)
  end

  def user_followings(token)
    @_user_followings ||= service.followings(token)
  end

  def service
    @_service ||= GithubService.new
  end
end
