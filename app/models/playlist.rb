class Playlist < ActiveRecord::Base
  after_create :generate_playlist

  has_many :video_fragments

  def directory
    "#{Rails.root}/public/video/#{self.id}/"
  end

  def playlist_url
    ENV["ROOT_URL"] + "/video/#{self.id}/prog_index.m3u8"
  end

  def video_url
    ENV["ROOT_URL"] + "/video/#{self.id}/"
  end

  # Create folder and playlist for content
  def generate_playlist
    FileUtils.mkdir_p(directory) unless File.directory?(directory)
    # Create the acutual m3u8 playlist.  ID of the playlist is the name
    unless File.exists? directory + "prog_index.m3u8"
      File.open("#{directory}/prog_index.m3u8", 'w') { |f|
        f << "#EXTM3U\n"
        f << "#EXT-X-VERSION:3\n"
        f << "#EXT-X-PLAYLIST-TYPE:EVENT\n"
        f << "#EXT-X-TARGETDURATION:#{VideoFragment::FRAGMENT_SIZE}\n"
        f << "#EXT-X-MEDIA-SEQUENCE:0\n"
      }
    end
  end
end
