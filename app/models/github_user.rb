class GithubUser
  attr_reader :name, :id

  def initialize(user_info)
    @name = user_info[:login]
    @id = user_info[:id]
  end
end
