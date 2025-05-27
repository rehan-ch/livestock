class AdminMailer < ApplicationMailer
  def new_ad_notification(ad)
    @ad = ad
    @user = ad.user
    mail(
      to: User.admin.pluck(:email),
      subject: "New Ad Created: #{@ad.name}"
    )
  end
end 