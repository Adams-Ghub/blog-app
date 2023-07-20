# frozen_string_literal: true

# Helps manage the mailing system of the app
class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com'
  layout 'mailer'
end
