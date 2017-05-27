class PopularWeeklyPosts < ApplicationJob
  def perform
    User.find_each do |user|
      PostMailer.popular_posts(user).deliver_later
    end
  end
end
