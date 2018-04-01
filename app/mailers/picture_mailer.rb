class PictureMailer < ApplicationMailer
  def picture_mail(picture)
   @picture = picture #ブログ投稿した人の情報をViewファイルに渡すことがでる

   mail to: @picture.user.email, subject: "Post完了メール"
  end
end
