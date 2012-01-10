class ContactMail < MailForm::Base
  attribute :email  
	attribute :telefoon
  attribute :message
  attribute :subject
	attribute :address

	validates :email, :presence => true
	validates :message, :presence => true 

  #attribute :nickname,  :captcha  => true

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
      :subject => %(<#{subject}>),
			:to => "luuk@den-teuling.nl",
      :from => "luuk@den-teuling.nl"
    }
  end
end
