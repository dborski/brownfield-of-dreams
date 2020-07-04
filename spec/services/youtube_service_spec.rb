require 'rails_helper'

describe 'Youtube API' do
  it 'sends repos for a single user' do
    id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
    youtube = YoutubeService.new
    playlists = youtube.playlist_info(id)
    playlist_items = youtube.playlist_videos_info(id)

    binding.pry
    
    expect(playlist_items).to be_a(Array)
    expect(playlist_items.first).to have_key(:name)
    expect(playlist_items.first).to have_key(:html_url)
  end

  # xit "sends followers for a single user" do
  #   id = ENV['GITHUB_API_KEY']
  #   github = GithubService.new
  #   followers = github.get_followers(token)

  #   expect(followers.first[:login]).to eq("alex-latham")
  #   expect(followers.count).to eq(3)
  # end
end