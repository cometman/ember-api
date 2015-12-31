class VideoFragment < ActiveRecord::Base
  # Video fragment size in seconds
  FRAGMENT_SIZE = 5

  after_commit :encode_fragment

  has_attached_file :fragment
  validates_attachment_content_type :fragment, :content_type => ["video", "video\/MP2T", "video\/mp2t", "video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]

  belongs_to :playlist

  # Encode the fragment into mpeg2-ts. Mediafilesegmenter provided by Apple does segmentation.
  def encode_fragment
    # Previx name of TS files.  mediafilesegmenter appends sequence nubmer
    fragment_prefix = "Fragment#{self.playlist.id}_"
    # Obtain duration of the clip.  Used to append to playlist
    duration = FFMPEG::Movie.new(self.fragment.path).duration
    number_of_segments = duration / FRAGMENT_SIZE
    encode_command = system("mediafilesegmenter -z none -i tmp.m3u8 -t #{FRAGMENT_SIZE} #{self.fragment.path} -B #{fragment_prefix} -f #{self.playlist.directory}")
    unless encode_command
      raise "Mediafilesegmenter failed!"
    else
      # Remove the extra media file created by mediafilesegmenter.  (We make our own)
      system("rm #{self.playlist.directory}tmp.m3u8")
      # Calculate number of entries to write (run once for every duration long segment
      # and also run an entry when a decimal exists
      entries = duration / FRAGMENT_SIZE.to_f
      if entries.modulo(1) > 0.01
        entries += 1
      end
      entries = entries.to_i
      entry_zero_index = entries - 1
      # Write the entry to the m3u8 playlist (Subtract one from entires for 0 based index)
      (0..entry_zero_index).each do |x|
        segment_count = (Playlist.find(self.playlist.id).fragment_count + x )
        fragment_duration = FFMPEG::Movie.new("#{self.playlist.directory+fragment_prefix+segment_count.to_s}.ts").duration
        File.open("#{self.playlist.directory}prog_index.m3u8", 'a') { |f|
          f << "#EXTINF:#{fragment_duration},\n"
          f << self.playlist.video_url + "#{fragment_prefix + segment_count.to_s}.ts\n"
        }
      end
    end
    self.playlist.fragment_count += entries
    self.playlist.save
  end
end
