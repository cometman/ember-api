class VideoFragment < ActiveRecord::Base
  has_attached_file :fragment
  validates_attachment_content_type :fragment, :content_type => ["video", "video\/MP2T", "video\/mp2t", "video/mp4", "video.MOV", "video/mpeg","video/mpeg4"]

  belongs_to :playlist
end
