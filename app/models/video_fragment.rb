class VideoFragment < ActiveRecord::Base
  # Video fragment size in seconds
  FRAGMENT_SIZE = 10

  after_create :encode_fragment

  has_attached_file :fragment
  validates_attachment_content_type :fragment, :content_type => ["video", "video\/MP2T", "video\/mp2t", "video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]

  belongs_to :playlist

  def encode_fragment
    duration = FFMPEG::Movie.new(self.fragment.path).duration
    number_of_segments = duration / FRAGMENT_SIZE
    # Write the entry to the m3u8 playlist
    File.open("#{self.playlist.directory + self.id}.m3u8", 'w') { |f|
      f << "#EXTINF:#{duration},"
      f << self.playlist.playlist_url
    }
    encode_command = system("mediafilesegmenter -t #{FRAGMENT_SIZE} #{self.fragment.path} -B #{self.playlist.id}_#{self.id} -f #{self.playlist.id}/")
    unless encode_command
      raise "Mediafilesegmenter failed!"
    else
      # File.open("#{DIRECTORY}/#{self.id}.m3u8", 'w') { |f|
      #   f << "#EXT-X-VERSION:3"
      #   f << "#EXTM3U"
      #   f << "#EXT-X-TARGETDURATION:5"
      #   f << "#EXT-X-MEDIA-SEQUENCE:1"
      # }
    end
  end
end
