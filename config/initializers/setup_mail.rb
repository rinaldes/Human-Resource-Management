# ActionMailer::Base.default_url_options = { :host => 'localhost:3000' }
# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = {
#     :address        => "smtp.gmail.com",
#     :port           => 587,
#     :domain         => "gmail.com",
#     :user_name      => "hrmpinus",
#     :password       => "passwordhrm",
#     :authentication => 'plain',
#     :enable_starttls_auto  => true
# }

ActionMailer::Base.default_url_options = { :host => 'localhost:3000' }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
    :address              => 'mail.pratesis.com',
    :port                 => 465,
    :domain               => 'pratesis.com',
    :user_name            => 'taufik_h',
    :password             => 'morpheus123',
    :authentication       => 'login',
    :ssl                  => true,
    :openssl_verify_mode  => 'none'
}