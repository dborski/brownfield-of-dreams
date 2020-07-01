class GithubUser
  attr_reader :name

  def initialize(user_info)
    @name = user_info[:login]
  end
end
