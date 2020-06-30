class GithubSearch

  def repos(token)
    repos = service.get_repos(token).map do |data|
      puts data
      GithubRepo.new(data)
    end
    repos
  end 

  def service
    GithubService.new
  end 
end 