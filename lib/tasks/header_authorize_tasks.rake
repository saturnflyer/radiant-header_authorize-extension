namespace :radiant do
  namespace :extensions do
    namespace :header_authorize do
      
      desc "Sets the 'authorization.header', 'authorization.attribute' and 'authorization.development.account' in Radiant::Config to the strings passed in with values such as HEADER='AUTHORIZED_USER', ATTRIBUTE='email' and DEV_ACCOUNT='admin'"
      task :set => :environment do
        if ENV['HEADER'].nil? && ENV['ATTRIBUTE'].nil? && ENV['DEV_ACCOUNT'].nil?
          puts "You must provide a HEADER, ATTRIBUTE or DEV_ACCOUNT, such as HEADER='AUTHORIZED_USER' ATTRIBUTE='email' DEV_ACCOUNT='admin'"
        else
          Radiant::Config[HEADER_AUTHORIZE_KEY] = "#{ENV['HEADER']}" if ENV['HEADER']
          Radiant::Config[HEADER_AUTHORIZE_ATTR] = "#{ENV['ATTRIBUTE']}" if ENV['ATTRIBUTE']
          Radiant::Config[HEADER_AUTHORIZE_DEV_ACCOUNT] = "#{ENV['DEV_ACCOUNT']}" if ENV['DEV_ACCOUNT']
        end
      end
      
    end
  end
end