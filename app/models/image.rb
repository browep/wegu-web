class Image < ActiveRecord::Base
  attr_accessible :url

  def self.next_display_day
    # find the latest display date
    latest = self.order("display_at DESC").limit(1)
    # add a day onto that.  if there is no date, just do yesterday
    if latest.nil? || latest.empty?
      return Time.now
    else
      latest[0].display_at + 1.days
    end
  end

  def save
    # get the latest display date, add a day
    if display_at.nil?
      self.display_at = Image.next_display_day
    end
    super
  end

  def self.current_image(time=Time.now)
    latest = self.order("display_at DESC").where("display_at <= ?",time).limit(1)
    latest.empty? ? nil : latest[0]

  end
end
