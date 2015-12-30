class VideoFragment < ActiveRecord::Base
  # Video fragment size in seconds
  FRAGMENT_SIZE = 10

  after_commit :encode_fragment

  has_attached_file :fragment
  validates_attachment_content_type :fragment, :content_type => ["video", "video\/MP2T", "video\/mp2t", "video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]

  belongs_to :playlist

  # Encode the fragment into mpeg2-ts. Mediafilesegmenter provided by Apple does segmentation.
  def encode_fragment
    Playlist.increment_counter(:fragment_count, self.playlist.id)
    # Previx name of TS files.  mediafilesegmenter appends sequence nubmer
    fragment_prefix = "Fragment#{self.playlist.id}_#{self.playlist.fragment_count}"
    # Obtain duration of the clip.  Used to append to playlist
    duration = FFMPEG::Movie.new(self.fragment.path).duration
    number_of_segments = duration / FRAGMENT_SIZE
    encode_command = system("mediafilesegmenter -z none -i tmp.m3u8 -t #{FRAGMENT_SIZE} #{self.fragment.path} -B #{fragment_prefix} -f #{self.playlist.directory}")
    unless encode_command
      raise "Mediafilesegmenter failed!"
    else
      # Remove the extra media file created by mediafilesegmenter.  (We make our own)
      system("rm #{self.playlist.directory}tmp.m3u8")
      # Write the entry to the m3u8 playlist
      File.open("#{self.playlist.directory}prog_index.m3u8", 'a') { |f|
        f << "#EXTINF:#{duration},\n"
        f << self.playlist.video_url + "#{fragment_prefix}.ts\n"
      }
    end
  end
end
