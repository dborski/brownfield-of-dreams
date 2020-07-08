require 'rails_helper'

describe 'Github Search', :vcr do
  it 'creates repo objects' do
    search = GithubSearch.new
    token = ENV['GITHUB_TOKEN1']


    repos = search.repos(token)

    expect(repos.first).to be_a(GithubRepo)
  end

  it 'creates github_user (follower) objects', :vcr do
    search = GithubSearch.new
    token = ENV['GITHUB_TOKEN1']

    followers = search.followers(token)

    expect(followers.first).to be_a(GithubUser)
  end

  it 'creates github_user (following) objects', :vcr do
    search = GithubSearch.new
    token = ENV['GITHUB_TOKEN1']

    following = search.following(token)

    expect(following.first).to be_a(GithubUser)
  end
end
