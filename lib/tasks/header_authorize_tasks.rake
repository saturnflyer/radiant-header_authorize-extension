namespace :radiant do
  namespace :extensions do
    namespace :header_authorize do
      
      desc "Sets the 'authorization.header' and 'authorization.attribute' in Radiant::Config to the strings passed in with HEADER='AUTHORIZED_USER' and ATTRIBUTE='email'"
      task :set => :environment do
        if ENV['HEADER'].nil? && ENV['ATTRIBUTE'].nil?
          puts "You must provide a HEADER or ATTRIBUTE, such as HEADER='AUTHORIZED_USER' ATTRIBUTE='email'"
        else
          Radiant::Config[HEADER_AUTHORIZE_KEY] = "#{ENV['HEADER']}" if ENV['HEADER']
          Radiant::Config[HEADER_AUTHORIZE_ATTR] = "#{ENV['ATTRIBUTE']}" if ENV['ATTRIBUTE']
        end
      end
      
    end
  end
end