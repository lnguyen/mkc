namespace :community do

  task :set_public => :environment do
    communities = Community.all
    communities.each do |community|
       community.view = 'Public'
       community.save
    end
  end   

end