class Mailer < ApplicationMailer
  layout false
  default from: "test@test.com"

  def share(contact, mail_to)
    @contact = contact
    @mail_to = mail_to
    mail(to: @mail_to, subject: "Contacts of #{contact.full_name}")
  end
end
