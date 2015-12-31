namespace :video do
  desc "Remove all directories and video files in public directory"
  task clean: :environment do
    puts `rm -rf #{Rails.root.join("public", "video")}`
  end

  desc "Destroy all local data including database."
  task nuke: :environment do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    puts `rm -rf #{Rails.root.join("public", "video")}`
  end

end
