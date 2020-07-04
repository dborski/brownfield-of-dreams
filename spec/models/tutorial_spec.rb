require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe 'instance_methods' do
    it 'create_playlists' do
      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
      tutorial = create(:tutorial)

      expect(tutorial.create_playlist(id)).to be_a(Tutorial) 
    end
    it 'create_playlist_videos' do
      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
      tutorial = create(:tutorial)

      expect(tutorial.create_playlist_videos(id).count).to be_eq(50) 
      expect(tutorial.create_playlist_videos(id).first).to be_a(Video) 
    end
  end
end
