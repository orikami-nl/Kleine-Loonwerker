class ContactMail < MailForm::Base
  attribute :info  
  attribute :message
  attribute :subject
	attribute :address

	validates :info, :presence => true
	validates :message, :presence => true 

  #attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => %(<#{subject}>),
			:to => "thijsvdlaar@hotmail.com",
      :from => "thijsvdlaar@hotmail.com"
    }
  end
end
