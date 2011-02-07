require "spec_helper"
#require "rspec"

describe "ImagesAPI" do

  before(:each) do
    #seed with a bunch of images
    first_image = Image.new({:url=>"http://imgur.com/first"})
    first_image.save.should == true

    second_image = Image.new({:url=>"http://imgur.com/second"})
    second_image.save.should == true

    third_image = Image.new({:url=>"http://imgur.com/third"})
    third_image.save.should == true

  end

  it "api call gives back at least some instances" do
    current_image = Image.current_image
    current_image.nil?.should == false
    
  end

  it "api call gives correct date v.1" do
    current_image = Image.current_image
    current_image.nil?.should == false
    current_image.url.should == "http://imgur.com/first"
  end

  it "api call should give correct date v.2" do
    current_image = Image.current_image(Time.now + 1.days + 10.seconds)
    current_image.nil?.should == false
    current_image.url.should == "http://imgur.com/second"

    current_image = Image.current_image(Time.now + 2.days + 10.seconds)
    current_image.nil?.should == false
    current_image.url.should == "http://imgur.com/third"
  end


  it "should return nothing when latest display day is more than a day ago" do
    current_image = Image.current_image(Time.now + 3.days + 10.seconds)
    current_image.nil?.should == true

  end

  it "should return something when calling random" do
    random_image = Image.random
    random_image.nil?.should == false

  end

end