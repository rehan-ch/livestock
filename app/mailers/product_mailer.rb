class ProductMailer < ApplicationMailer
  def approval_notification(product)
    @product = product
    @user = product.user
    mail(
      to: @user.email,
      subject: "Your Ad '#{@product.name}' has been approved!"
    )
  end

  def rejection_notification(product)
    @product = product
    @user = product.user
    mail(
      to: @user.email,
      subject: "Your Ad '#{@product.name}' has been rejected"
    )
  end
end 