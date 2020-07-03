require 'rails_helper'

describe 'Github API' do
  it 'sends repos for a single user' do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    repos = github.get_repos(token)

    
    expect(repos).to be_a(Array)
    expect(repos.first).to have_key(:name)
    expect(repos.first).to have_key(:html_url)
  end

  it "sends followers for a single user" do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    followers = github.get_followers(token)

    expect(followers.first).to have_key(:login)
    expect(followers.count).to eq(3)
  end
end
