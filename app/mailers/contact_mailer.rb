class ContactMailer < ApplicationMailer
  def new_submission(contact_submission)
    @contact_submission = contact_submission
    mail(to: 'admin@example.com', subject: 'New Contact Form Submission')
  end
end