class User < ApplicationRecord
  has_many :user_videos, dependent: :destroy
  has_many :videos, through: :user_videos
  has_many :tutorials, through: :videos
  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  validates :email, uniqueness: true, presence: true
  validates :first_name, presence: true
  enum role: { default: 0, admin: 1 }
  has_secure_password

  def user_repos(count = 50)
    search = GithubSearch.new
    repos = search.repos(github_token) if github_token
    return nil unless repos

    repos[0...count]
  end

  def user_followers(count = 50)
    GithubSearch.new.followers(github_token)[0...count] if github_token
  end

  def user_following(count = 50)
    GithubSearch.new.following(github_token)[0...count] if github_token
  end

  def repos?
    user_repos != nil
  end

  def unique_tutorials
    tutorials.distinct
  end

  def self.is_user?(github_user)
    User.exists?(github_username: github_user.name)
  end

  def is_friend?(github_user)
    friends.exists?(github_id: github_user.id)
  end

  def friend_list
    friends
  end
end
