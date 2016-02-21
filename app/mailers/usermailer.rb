class Usermailer < ApplicationMailer
  default from: 'leon486@gmail.com'
     layout 'mailer'
     def movie_notification_email(m)
        c = Config.find_by(parameter:'emails')
#        @user = user
#        @url  = 'http://www.gmail.com'
        mail(to: c.value, subject: 'Welcome to My Awesome Site')
     end
end
