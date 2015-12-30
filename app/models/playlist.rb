class Playlist < ActiveRecord::Base
  after_create :generate_playlist

  has_many :video_fragments

  def directory
    "#{Rails.root}/public/video/#{self.id}/"
  end

  def playlist_url
    root_url + "/public/video/#{self.id}/#{self.id}.m3u8"
  end

  # Create folder and playlist for content
  def generate_playlist
    FileUtils.mkdir_p(directory) unless File.directory?(directory)
    # Create the acutual m3u8 playlist.  ID of the playlist is the name
    unless File.exists? directory + "#{self.id}.m3u8"
      File.open("#{directory}/#{self.id}.m3u8", 'w') { |f|
        f << "#EXT-X-VERSION:3"
        f << "#EXTM3U"
        f << "#EXT-X-TARGETDURATION:5"
        f << "#EXT-X-MEDIA-SEQUENCE:1"
      }
    end
  end
end
