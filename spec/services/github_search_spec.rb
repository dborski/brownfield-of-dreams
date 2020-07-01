require 'rails_helper'

describe 'Github Search' do
  it 'creates repo objects' do
    search = GithubSearch.new
    token = ENV['GITHUB_API_KEY']


    repos = search.repos(token)

    expect(repos.first).to be_a(GithubRepo)
    expect(repos.first.name).to eq("brownfield-of-dreams")
  end

  it 'creates github_user (follower) objects' do
    search = GithubSearch.new
    token = ENV['GITHUB_API_KEY']

    followers = search.followers(token)

    expect(followers.first).to be_a(GithubUser)
    expect(followers.first.name).to eq('alex-latham')
  end
end
