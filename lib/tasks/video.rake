namespace :video do
  desc "Remove all directories and video files in public directory"
  task clean: :environment do
    puts `rm -rf #{Rails.root.join("public", "video")}`
  end

end
