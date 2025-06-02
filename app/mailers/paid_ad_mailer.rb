class PaidAdMailer < ApplicationMailer
  def approval_notification(paid_ad)
    @paid_ad = paid_ad
    @user = paid_ad.user
    mail(
      to: @user.email,
      subject: "Your Paid Ad Request has been approved!"
    )
  end

  def rejection_notification(paid_ad)
    @paid_ad = paid_ad
    @user = paid_ad.user
    mail(
      to: @user.email,
      subject: "Your Paid Ad Request has been rejected"
    )
  end
end 