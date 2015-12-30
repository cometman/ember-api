class VideoFragment < ActiveRecord::Base
  after_create :encode_fragment
  
  has_attached_file :fragment
  validates_attachment_content_type :fragment, :content_type => ["video", "video\/MP2T", "video\/mp2t", "video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]

  belongs_to :playlist

  def encode_fragment
    `mediafilesegmenter -t 5 #{self.fragment.path} -B #{self.playlist.id}_#{Time.now.to_i}`
  end
end
