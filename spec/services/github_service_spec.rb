require 'rails_helper'

describe 'Github API' do
  it 'sends repos for a single user' do
    token = ENV['GITHUB_API_KEY']
    github = GithubService.new
    repos = github.repos_by_user(token)


    expect(repos.first[:name]).to eq("brownfield-of-dreams")
    expect(repos.count).to eq(30)
  end
end