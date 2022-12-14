class UserDeviseMailer < Devise::Mailer
  helper :application
  helper MailerHelper
  include Devise::Controllers::UrlHelpers
  default template_path: 'devise/mailer'

  def reset_password_instructions(record, token, opts = {})
    attachments.inline['logo.png'] = File.read("#{Rails.root}/app/assets/images/logo.png")

    super(record, token, opts)
  end
end
