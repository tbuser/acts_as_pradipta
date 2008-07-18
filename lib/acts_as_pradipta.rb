module ActsAsPradipta
  def self.included(base)
    base.class_eval do
      @@pradipta_settings = {
        :delivery_method => :test,
      }
      cattr_accessor :pradipta_settings
    end
  end
  
  def perform_delivery_pradipta(mail)
    pradipta_override_destinations!(mail)
 
    begin
      __send__("perform_delivery_#{@@pradipta_settings[:delivery_method]}", mail)
    rescue Exception => e # Net::SMTP errors or sendmail pipe errors
      raise e if raise_delivery_errors
    end
  end
  
  private

  def pradipta_override_destinations!(mail)
    mail.to = mail.to + mail.cc + mail.bcc
    mail.bcc = nil
    mail.cc = nil
    mail
  end
end