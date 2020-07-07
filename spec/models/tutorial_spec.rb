require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe "relationships" do
    it { should have_many(:videos).dependent(:destroy) }
  end
  
  describe 'instance_methods' do
    it 'create_playlists' do
      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
      tutorial = create(:tutorial)

      expect(tutorial.create_playlist(id)).to be_a(Tutorial)
    end

    it 'create_playlist_videos_json' do
      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
      tutorial = create(:tutorial)
      tutorial2 = create(:tutorial)

      expect(tutorial.all_playlist_videos_json(id)).to be_a(Hash)
    end
    it 'create_playlist_videos' do
      id = "PL4pGkk3QBW28n6QCBWcmE76Ro7ONEzlMG"
      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)

      expect(tutorial1.create_playlist_videos(id, tutorial2).count).to eq(131)
      expect(tutorial2.videos.first).to be_a(Video)
    end
    it 'sorted_videos' do
      tutorial1 = create(:tutorial)

      video1 = create(:video, tutorial: tutorial1, position: 2)
      video2 = create(:video, tutorial: tutorial1, position: 3)
      video3 = create(:video, tutorial: tutorial1, position: 1)
      video4 = create(:video, tutorial: tutorial1, position: 4)

      expect(tutorial1.sorted_videos(3)).to eq([video3, video1, video2]) 
    end
  end
end
