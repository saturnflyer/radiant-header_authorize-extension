namespace :radiant do
  namespace :extensions do
    namespace :header_authorize do
      
      desc "Sets the 'authorization.header' in Radiant::Config to the string passed in with HEADER='AUTHORIZED_USER'"
      task :set => :environment do
        if ENV['HEADER'].nil?
          puts "You must provide a HEADER, such as HEADER='AUTHORIZED_USER'"
        else
          Radiant::Config[HEADER_AUTHORIZE_KEY] = "#{ENV['HEADER']}"
        end
      end
      
    end
  end
end