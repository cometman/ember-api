module API
  module V1
    class Playlists < Grape::API
      include API::V1::Defaults
      resource :playlists do

        desc "Return all active playlists"
        get "", root: :playlists do
          Playlist.all
        end

        desc "Return a HLS playlist"
        params do
          requires :id, type: String, desc: "ID of the playlist"
        end
        get ":id", root: "playlist" do
          Playlist.where(id: permitted_params[:id]).first!
        end
      end
    end
  end
end
