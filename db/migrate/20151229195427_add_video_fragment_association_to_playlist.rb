class AddVideoFragmentAssociationToPlaylist < ActiveRecord::Migration
  def self.up
    add_column :video_fragments, :playlist_id, :integer
    add_index 'video_fragments', ['playlist_id'], :name => 'index_playlist_id'
  end

  def self.down
    remove_column :video_fragments, :playlist_id
  end
end
