module API
  module V1
    class VideoFragments < Grape::API
      include API::V1::Defaults

      resource :video_fragments do
        desc "Return all video fragments"
        get "", root: :video_fragments do
          VideoFragment.all
        end
      end
    end
  end
end
