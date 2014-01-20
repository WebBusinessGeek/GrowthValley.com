class ContactUsController < ApplicationController

  def create
    if verify_recaptcha
      ContactUsMailer.send_message(params[:name], params[:email], params[:message]).deliver

      redirect_to root_path, notice: 'Message sent sucessfully!'
    else
      redirect_to root_path, alert: 'Captcha verification failed...'
    end
  end
end
