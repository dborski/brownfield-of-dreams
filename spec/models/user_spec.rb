require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:email)}
    it {should validate_presence_of(:first_name)}
    it {should validate_presence_of(:password)}
  end

  describe 'relationships' do
    it { should have_many(:user_videos).dependent(:destroy)}
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name:'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name:'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
  describe 'instance_methods' do
    it 'user_repos' do
      user1 = create(:user)
      user2 = create(:user, github_token: nil)

      expect(user1.user_repos(5).count).to eq(5)
      expect(user1.user_repos(5).first).to be_a(GithubRepo)

      expect(user2.user_repos(5)).to eq(nil)
    end
    it 'repos?' do
      user1 = create(:user)
      user2 = create(:user, github_token: nil)

      expect(user1.repos?).to eq(true)
      expect(user2.repos?).to eq(false)
    end
    it 'unique_tutorials' do
      user = create(:user)

      tutorial1 = create(:tutorial)
      tutorial2 = create(:tutorial)
      tutorial3 = create(:tutorial)

      video1 = create(:video, tutorial: tutorial1, position: 2)
      video2 = create(:video, tutorial: tutorial2, position: 1)
      video3 = create(:video, tutorial: tutorial3, position: 3)
      video4 = create(:video, tutorial: tutorial3, position: 4)

      UserVideo.create!(user: user, video: video1)
      UserVideo.create!(user: user, video: video2)
      UserVideo.create!(user: user, video: video3)
      UserVideo.create!(user: user, video: video4)

      expect(user.unique_tutorials).to eq([tutorial1, tutorial2, tutorial3]) 
    end
  end
end
