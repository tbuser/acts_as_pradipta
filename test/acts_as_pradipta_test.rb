require File.join(File.dirname(__FILE__),'/test_helpers')
require 'test/unit'

class ActsAsPradiptaTest < Test::Unit::TestCase
  def setup
    ActionMailer::Base.delivery_method = :test
    ActionMailer::Base.deliveries = []
    ActionMailer::Base.pradipta_settings = {}
   
    @expected = mail_fixture
  end
   
  def teardown
    ActionMailer::Base.delivery_method = :test
  end
  
  def test_should_rewrite_recipients
    ActionMailer::Base.pradipta_settings = {
      :delivery_method => :test
    }
    
    ActionMailer::Base.delivery_method = :pradipta
    
    assert MyTestDelivery.deliver_recruitment
    assert_equal ["foo@bar.com", "bing@bang.com", "ding@dong.com"], ActionMailer::Base.deliveries.first.destinations
  end 
  
  private

  def mail_fixture
    expected = new_mail
    expected.to = 'foo@bar.com'
    expected.cc = 'bing@bang.com'
    expected.bcc = 'ding@dong.com'
    expected.subject = 'Ruby on Rails position...'
    expected.body = "I have a couple of Ruby on Rails position, wanted to know if you are interested?\n\n\n    Max Archie\n    Technical Recruiter\n    Prodigus Source\n    Cell: 219-669-9216\n    Phone: 312-235-2365\n    Max@prodigussource.com"
    expected.from = 'max@prodigussource.com'
    expected.date = Time.local 2008, 7, 17
    expected
  end
  
  def new_mail( charset="utf-8" )
    mail = TMail::Mail.new
    mail.mime_version = "1.0"
    if charset
      mail.set_content_type "text", "plain", { "charset" => charset }
    end
    mail
  end
end
