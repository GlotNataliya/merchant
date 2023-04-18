# frozen_string_literal: true

class Feedback < MailForm::Base
  attribute :name, validate: true, length: { minimum: 2 }
  attribute :email, validate: /\A([\w.%+-]+)@([\w-]+\.)+(\w{2,})\z/i
  attribute :message, validate: true, length: { minimum: 10 }
  attribute :term, validate: true
  attribute :nickname, captcha: true

  def headers
    {
      subject: "My Feedback Form",
      to: "merchant@example.com",
      from: %("#{name}" <#{email}>)
    }
  end
end
