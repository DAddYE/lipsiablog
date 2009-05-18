class Notifier < ActionMailer::Base
  helper FrontendHelper
  
  def registration(account)
    from_mail     = Setting.first.email rescue AppConfig.email_from
    subject_mail  = Setting.first.name rescue AppConfig.project
    recipients  account.email
    from        from_mail
    subject     "[#{subject_mail}] #{I18n.t('backend.emails.registration.object')}"
    body        :account => account, :url => "http://#{AppConfig.host_addr}/backend"
  end
  
  def support_request(account, message)
    from        account.email
    recipients  AppConfig.email_help
    subject     "[#{AppConfig.project}] #{I18n.t('backend.emails.support.object')}"
    body        :message => message
  end
  
  def contact(contact)
    from        contact.email
    recipients  "info@lipsiasoft.com"
    subject     "[#{Setting.first.name}] Nuovo contatto dal sito"
    body        :contact => contact
  end
  
  def comment(comment)
    from        comment.email
    recipients  Setting.first.email
    subject     "[#{Setting.first.name}] Nuovo commento ricevuto"
    body        :comment => comment
  end

  def post(post)
    from        post.account.email
    recipients  Setting.first.email
    subject     "[#{Setting.first.name}] Nuovo articolo inserito"
    body        :post => post
  end
end 