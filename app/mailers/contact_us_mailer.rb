class ContactUsMailer < ActionMailer::Base
  default from: "no-reply@growthvalley.com"

  def send_message(name, email, msg)
    email_with_name = "#{name} <#{email}>"

    @msg = msg
    @name = name
    @email = email

    mail(:from => email_with_name, :to => "Jony Malhotra <jony@idifysolutions.com>", :subject => "Feedback from GrowthValley") do |format|
      format.html
    end
  end
end
