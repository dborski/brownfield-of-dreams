require 'rails_helper'

describe 'GithubRepo' do
  it 'exists' do
  repo = GithubRepo.new({name: "brownfield-of-dreams", html_url: "https://github.com/dborski/brownfield-of-dreams"})

  expect(repo).to be_a(GithubRepo)
  end

  it 'attributes' do
  repo = GithubRepo.new({name: "brownfield-of-dreams", html_url: "https://github.com/dborski/brownfield-of-dreams"})

  expect(repo.name).to eq("brownfield-of-dreams")
  expect(repo.url).to eq("https://github.com/dborski/brownfield-of-dreams")
  end
end