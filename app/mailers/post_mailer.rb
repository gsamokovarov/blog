class PostMailer < ApplicationMailer
  def popular_posts(user)
    @posts = Post.popular

    mail to: user.email
  end
end
