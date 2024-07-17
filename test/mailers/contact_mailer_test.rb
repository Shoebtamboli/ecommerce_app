require "test_helper"

class ContactMailerTest < ActionMailer::TestCase
  test "new_submission" do
    mail = ContactMailer.new_submission
    assert_equal "New submission", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
