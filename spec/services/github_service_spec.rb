require 'rails_helper'

describe 'Github API' do
  it 'sends repos for a single user', :vcr do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    repos = github.get_repos(token)

    
    expect(repos).to be_a(Array)
    expect(repos.first).to have_key(:name)
    expect(repos.first).to have_key(:html_url)
  end

  it "sends followers for a single user", :vcr do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    followers = github.get_followers(token)

    expect(followers.first).to have_key(:login)
    expect(followers.count).to eq(3)
  end

  it 'gets user info', :vcr do 
    handle = "dborski"
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    user_info = github.get_user_info(handle, token)

    expect(user_info).to have_key(:login)
    expect(user_info).to have_key(:email)
  end

  it "get github user info", :vcr do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    user_info = github.get_authenticated_user_info(token)

    expect(user_info).to have_key(:login)
    expect(user_info).to have_key(:email)
  end
end
