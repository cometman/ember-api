module API
  module V1
    class VideoFragments < Grape::API
      include API::V1::Defaults

      resource :video_fragments do
        desc "Return all video fragments"
        get "", root: :video_fragments do
          VideoFragment.all
        end

        desc "Upload a video fragment"
        params do
          optional :id, type: String, desc: "ID of the playlist.  Leave blank to create a new playlist"
        end
        post "", root: :video_fragments do
          playlist = Playlist.where(id: params[:id]).first || Playlist.create(name: params[:name])
          VideoFragment.create!(fragment: params[:fragment], playlist: playlist)
        end
      end
    end
  end
end
