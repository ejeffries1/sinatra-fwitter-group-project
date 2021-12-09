class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  
      def self.find_by_slug(slug)
        self.all.find {|instance| instance.slug == slug}
      end

  
      def slug
        self.username.gsub(/ /, "-")
      end

end
