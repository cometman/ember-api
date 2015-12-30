FactoryGirl.define do
  factory :video_fragment do
    # fragment {Rack::Test::UploadedFile.new(File.join(Rails.root.join("spec", "video"), "main.ts"), "video/MP2T")}
    fragment {File.open(Rails.root.join("spec", "video", "logo_sting.mp4"))}
    # fragment {File.open(Rails.root.join("spec", "video", "main.ts"))}

    playlist

  end
end
