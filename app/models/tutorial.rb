class Tutorial < ApplicationRecord
  has_many :videos, -> { order(position: :ASC) },
    inverse_of: :tutorial,
    dependent: :destroy
  acts_as_taggable_on :tags, :tag_list
  accepts_nested_attributes_for :videos

  def create_playlist(playlist_id)
    playlist_json = YoutubeService.new.playlist_info(playlist_id)
    playlist_info = playlist_json[:items][0]

    Tutorial.create(
      title: playlist_info[:snippet][:title],
      description: playlist_info[:snippet][:description],
      thumbnail: playlist_info[:snippet][:thumbnails][:high][:url],
      playlist_id: playlist_info[:id]
    )
  end

  def all_playlist_videos_json(playlist_id)
    playlist_videos_json = YoutubeService.new.playlist_videos_info(playlist_id)

    next_page_token = playlist_videos_json[:nextPageToken]
    while next_page_token
      next_fifty_videos = YoutubeService.new.playlist_videos_info(playlist_id, next_page_token)
      playlist_videos_json[:items] << next_fifty_videos[:items]
      next_page_token = next_fifty_videos[:nextPageToken]
    end
    playlist_videos_json
  end

  def create_playlist_videos(playlist_id, new_tutorial)
    all_playlist_videos_json(playlist_id)[:items].flatten.each.with_index(1) do |vid, index|
      if vid[:status][:privacyStatus] == 'public'
        new_tutorial.videos.create!(
          title: vid[:snippet][:title],
          description: vid[:snippet][:description],
          thumbnail: vid[:snippet][:thumbnails][:high][:url],
          video_id: vid[:snippet][:resourceId][:videoId],
          position: index
        )
      end
    end
  end
end
