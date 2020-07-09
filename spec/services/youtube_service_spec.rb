require 'rails_helper'

describe 'Youtube API' do
  it 'gets playlist info', :vcr do
    id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
    youtube = YoutubeService.new
    playlist_json = youtube.playlist_info(id)
    playlist_info = playlist_json[:items][0]

    expect(playlist_info[:snippet]).to have_key(:title)
    expect(playlist_info[:snippet]).to have_key(:description)
    expect(playlist_info[:snippet][:thumbnails][:high]).to have_key(:url)
    expect(playlist_info).to have_key(:id)
  end

  it 'gets playlist videos info', :vcr do
    id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
    youtube = YoutubeService.new
    playlist_videos_json = youtube.playlist_videos_info(id)
    playlist_videos_info = playlist_videos_json[:items]

    expect(playlist_videos_info).to be_a(Array)
    expect(playlist_videos_info.first[:snippet]).to have_key(:title)
    expect(playlist_videos_info.first[:snippet]).to have_key(:description)
    expect(playlist_videos_info.first[:snippet][:thumbnails][:high]).to have_key(:url)
    expect(playlist_videos_info.first[:snippet][:resourceId]).to have_key(:videoId)
  end
end