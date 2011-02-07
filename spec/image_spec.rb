require "spec_helper"
require "rspec"

describe "Images" do

  before(:each) do

  end

  it "should be a day older than last one" do
    first_image = Image.new({:url=>"http://imgur.com/this"})
    first_image.save.should == true

    second_image = Image.new({:url=>"http://imgur.com/this"})
    second_image.save.should == true
    
    second_image.display_at.should < Time.now + 1.days
    second_image.display_at.should > (Time.now + 1.days) - 10

    third_image = Image.new({:url=>"http://imgur.com/this"})
    third_image.save.should == true


    third_image.display_at.should < Time.now + 2.days
    third_image.display_at.should > (Time.now + 2.days) - 10

  end

  it "first in db should have current time as display date" do
    first_image = Image.new({:url=>"http://imgur.com/this"})
    first_image.save.should == true
    first_image.display_at.should < Time.now
    first_image.display_at.should > Time.now - 10


  end

  it "when nothing in db, get_next_display_time should be within 10s of now" do
    display_time = Image.next_display_day.should
    display_time.should < Time.now
    display_time.should > Time.now - (5 * 60)

  end

  it "should be the current image when most recent display time was more than a day ago" do
    old_image = Image.new({:url=>"http://imgur.com/old"})
    old_image.save.should == true

    # set the image display_at to 2 days ago
    old_image.update_attributes({"display_at",(Time.now - 2.days)})

    new_image = Image.new({:url=>"http://imgur.com/new"})
    new_image.save.should == true
    new_image.display_at.should > Time.now - 10.seconds
    new_image.display_at.should < Time.now + 10.seconds

  end




end