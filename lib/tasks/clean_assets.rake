namespace :maintenance do
  desc "Removes orphaned assets"
  task :clean_orphaned_assets => :environment do
    Course.all.each do |c|
      unless Rails.application.assets.find_asset c.course_cover_pic.to_s
        puts "Removing #{c.course_cover_pic.to_s}"
        c.remove_course_cover_pic!
        c.save
      end
    end
    User.all.each do |u|
      unless Rails.application.assets.find_asset u.profile_pic.to_s
        puts "Removing #{u.profile_pic.to_s}"
        u.remove_profile_pic!
        u.save
      end
    end
    Bundle.all.each do |b|
      unless Rails.application.assets.find_asset b.bundle_pic.to_s
        puts "Removing #{b.bundle_pic.to_s}"
        b.remove_bundle_pic!
        b.save
      end
    end
    Section.all.each do |s|
      unless Rails.application.assets.find_asset s.attachment.to_s
        puts "Removing #{s.attachment.to_s}"
        s.remove_attachment!
        s.save
      end
    end
  end
end