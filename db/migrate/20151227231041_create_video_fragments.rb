class CreateVideoFragments < ActiveRecord::Migration
  def change
    create_table :video_fragments do |t|

      t.timestamps null: false
    end
  end
end
