class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates :password, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def user_repos(count = 50)
    search = GithubSearch.new
    repos = search.repos(github_token) if github_token
    return nil if !repos

    repos[0...count]
  end

  def has_repos?
    user_repos != nil
  end
end
