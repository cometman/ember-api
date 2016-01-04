FactoryGirl.define do
  factory :video_fragment do
    fragment {File.open(Rails.root.join("spec", "video", "pitch.mov"))}
    playlist
  end
end
