require 'rails_helper'

describe 'Github Search' do
  it 'creates repo objects' do
    search = GithubSearch.new
    token = ENV['GITHUB_API_KEY']


    repos = search.repos(token)

    expect(repos.first).to be_a(GithubRepo)
    expect(repos.first.name).to eq("brownfield-of-dreams")
  end
end