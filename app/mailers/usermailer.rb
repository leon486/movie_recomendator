class Usermailer < ApplicationMailer
  default from: 'leon486@gmail.com'
     layout 'mailer'
     def movie_notification_email(m)
        c = Config.find_by(parameter:'emails')
        mail(to: c.value, subject: 'New movie release notification')
     end
end
