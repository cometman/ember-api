class AddFragmentCountToPlaylists < ActiveRecord::Migration

  def self.up
    add_column :playlists, :fragment_count, :integer, :null => false, :default => 0
  end

  def self.down

  end

end
