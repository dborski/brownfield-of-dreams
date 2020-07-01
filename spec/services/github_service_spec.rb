require 'rails_helper'

describe 'Github API' do
  it 'sends repos for a single user' do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    repos = github.get_repos(token)


    expect(repos.first[:name]).to eq("brownfield-of-dreams")
    expect(repos.count).to eq(30)
  end

  it "sends followers for a single user" do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    followers = github.get_followers(token)

    expect(followers.first[:login]).to eq("alex-latham")
    expect(followers.count).to eq(3)
  end
end
