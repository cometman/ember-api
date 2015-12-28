class AddAttachmentFragmentToVideoFragments < ActiveRecord::Migration
  def self.up
    change_table :video_fragments do |t|
      t.attachment :fragment
    end
  end

  def self.down
    remove_attachment :video_fragments, :fragment
  end
end
