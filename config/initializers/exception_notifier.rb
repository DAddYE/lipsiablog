Lipsiadmin::Mailer::ExceptionNotifier.sender_address       = %("Exception Notifier" <exceptions@lipsiasoft.com>)
Lipsiadmin::Mailer::ExceptionNotifier.recipients_addresses = %(help@lipsiasoft.com)
Lipsiadmin::Mailer::ExceptionNotifier.email_prefix         = "[LipsiaAdmin]"
Lipsiadmin::Mailer::ExceptionNotifier.send_mail            = true

# Uncomment this if this mail is for redmine handler
Lipsiadmin::Mailer::ExceptionNotifier.extra_options        = { :project => "lipsiabug", :tracker => "Bug", :priority => "Immediata" }