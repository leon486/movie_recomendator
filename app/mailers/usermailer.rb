class Usermailer < ApplicationMailer
  default from: 'notifications@masthead.com'
   
     def movie_notification_email(m)
        c = Config.find_by(parameter:'emails')
#        @user = user
#        @url  = 'http://www.gmail.com'
        mail(to: c.emails, subject: 'Welcome to My Awesome Site')
     end
end
