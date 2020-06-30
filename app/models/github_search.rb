class GithubSearch

  def repos(token)
    service.get_repos(token).map do |data|
      GithubRepo.new(data)
    end
  end 

  def service
    GithubService.new
  end 
end 