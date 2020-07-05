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
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)


      expect(tutorial1.create_playlist_videos(id, tutorial2).count).to eq(131) 
      expect(tutorial2.videos.first).to be_a(Video) 
    end
  end
end
