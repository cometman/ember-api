class Playlist < ActiveRecord::Base
  DIRECTORY = "#{Rails.root}/public/video/"
  after_create :generate_playlist

  has_many :video_fragments


  # Create folder and playlist for content
  def generate_playlist
    dir = File.dirname("#{DIRECTORY}#{self.id}/")
    FileUtils.mkdir_p(dir)
    # Create the acutual m3u8 playlist.  ID of the playlist is the name
    open("#{self.id}.m3u8", 'w') { |f|
      f << "#EXT-X-VERSION:3"
      f << "#EXTM3U"
      f << "#EXT-X-TARGETDURATION:5"
      f << "#EXT-X-MEDIA-SEQUENCE:1"
    }
  end
end
