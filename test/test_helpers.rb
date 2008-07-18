require 'test/unit'
$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'rubygems'
require 'action_mailer'
# require 'mocha'
require 'acts_as_pradipta.rb'
ActionMailer::Base.send :include, ActsAsPradipta
 
ActionMailer::Base.pradipta_settings = {
    :delivery_method => :test
}
 
class MyTestDelivery < ActionMailer::Base
  def recruitment
    from 'max@prodigussource.com'
    recipients 'foo@bar.com'
    cc 'bing@bang.com'
    bcc 'ding@dong.com'
    sent_on Time.local(2008, 7, 17)
    subject 'Ruby on Rails position...'
    body "I have a couple of Ruby on Rails position, wanted to know if you are interested?\n\n\n    Max Archie\n    Technical Recruiter\n    Prodigus Source\n    Cell: 219-669-9216\n    Phone: 312-235-2365\n    Max@prodigussource.com"
  end
end