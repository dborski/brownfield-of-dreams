class GithubService
  def get_repos(github_token)
    params = { sort: 'created', direction: 'desc' }

    get_json('user/repos', github_token, params)
  end

  def get_followers(github_token)
    get_json('user/followers', github_token, nil)
  end

  def get_following(github_token)
    get_json('user/following', github_token, nil)
  end

  def get_user_info(handle, github_token)
    get_json("users/#{handle}", github_token, nil)
  end

  def get_authenticated_user_info(github_token)
    get_json('user', github_token, nil)
  end

  private

  def get_json(url, github_token, params = nil)
    response = conn.get(url, params) do |request|
      request.headers['Authorization'] = "token #{github_token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end
