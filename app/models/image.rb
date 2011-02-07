class Image < ActiveRecord::Base
  attr_accessible :url,:display_at

  def self.next_display_day
    # find the latest display date
    latest = self.order("display_at DESC").limit(1)
    # add a day onto that.  if there is no date, just do yesterday
    if latest.nil? || latest.empty?
      return Time.now
    else
      time = latest[0].display_at + 1.days
      time < Time.now - 1.days ? Time.now : time
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
    latest = self.order("display_at DESC").where("display_at <= ? AND display_at >= ? ",time,time - 1.day).limit(1)
    latest.empty? ? nil : latest[0]

  end

  def self.random
    random = self.order("RAND()").limit(1)
    random.empty? ? nil : random[0]
    
  end
end
