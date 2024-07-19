require 'rails_helper'

RSpec.describe ContactSubmission, type: :model do
  it "is valid with valid attributes" do
    submission = ContactSubmission.new(name: "John Doe", email: "john@example.com", message: "Test message")
    expect(submission).to be_valid
  end

  it "is not valid without a name" do
    submission = ContactSubmission.new(name: nil)
    expect(submission).to_not be_valid
  end

  it "is not valid without an email" do
    submission = ContactSubmission.new(email: nil)
    expect(submission).to_not be_valid
  end

  it "is not valid with an invalid email format" do
    submission = ContactSubmission.new(email: "invalid_email")
    expect(submission).to_not be_valid
  end

  it "is not valid without a message" do
    submission = ContactSubmission.new(message: nil)
    expect(submission).to_not be_valid
  end
end