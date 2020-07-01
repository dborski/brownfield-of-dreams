class GithubService

  def get_repos(github_token)
    params = {sort: "created", direction: "desc"}

    get_json('user/repos', params, github_token)
  end 

  private

  def get_json(url, params = nil, github_token)
    response = conn.get(url, params) do |repo|
      repo.headers["Authorization"] = "token #{github_token}"
    end
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new(url: 'https://api.github.com') do |f|
      f.adapter Faraday.default_adapter
    end
  end
end