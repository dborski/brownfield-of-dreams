require 'rails_helper'

describe 'Youtube API' do
  it 'gets playlist info' do
    id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
    youtube = YoutubeService.new
    playlist_json = youtube.playlist_info(id)
    playlist_info = playlist_json[:items][0]

    expect(playlist_info[:snippet]).to have_key(:title)
    expect(playlist_info[:snippet]).to have_key(:description)
    expect(playlist_info[:snippet][:thumbnails][:high]).to have_key(:url)
    expect(playlist_info).to have_key(:id)
  end

  xit 'gets playlist videos info' do
    id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
    youtube = YoutubeService.new
    playlist_videos_json = youtube.playlist_videos_info(id)
    playlist_videos_info = playlist_videos_json[:items]

    binding.pry

    expect(playlist_videos_info).to be_a(Array)
    expect(playlist_videos_info.first[:vid]).to have_key(:title)
    expect(playlist_videos_info.first).to have_key(:description)
    expect(playlist_videos_info.first).to have_key(:thumbnail)
    expect(playlist_videos_info.first).to have_key(:playlist_id)
    expect(playlist_videos_info.first).to have_key(:classroom)
  end
end