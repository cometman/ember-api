class AddFragmentCountToPlaylists < ActiveRecord::Migration

  def self.up
    add_column :playlists, :fragment_count, :integer, :null => false, :default => 0
    add_column :playlists, :name, :string
  end

  def self.down

  end

end
