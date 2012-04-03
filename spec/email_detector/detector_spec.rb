require 'spec_helper'
require 'email_detector'

describe EmailDetector::Detector do
  describe "given a blank string" do
    before do
      @it = EmailDetector::Detector.new("")
    end
  
    it "is empty" do
      @it.should be_empty
    end
  
    it "stringifies to the empty string" do
      @it.to_s.should eq("")
    end
    
    it "arrayifies to the empty array" do
      @it.to_a.should eq([])
    end
  end
  
  describe "given emails separated by commas" do
    before do
      @it = EmailDetector::Detector.new("test@example.com, bob@example.com, jim@example.com")
    end
    
    it "is not empty" do
      @it.should_not be_empty
    end
    
    it "stringifies to a comma-separated list" do
      @it.to_s.should eq("test@example.com, bob@example.com, jim@example.com")
    end
    
    it "arrayifies to a list of strings" do
      @it.to_a.should eq(%w[test@example.com bob@example.com jim@example.com])
    end
  end
  
  describe "given duplicate emails" do
    before do
      @it = EmailDetector::Detector.new("test@example.com, bob@example.com, Test <test@example.com>")
    end
    
    it "eliminates duplicates" do
      @it.to_a.should eq(%w[test@example.com bob@example.com])
    end
  end
  
  describe "given duplicate emails with different case" do
    before do
      @it = EmailDetector::Detector.new("Test Lowercase <test@example.com>, bob@example.com, Test Uppercase <TEST@example.com>")
    end
    
    it "eliminates duplicates" do
      @it.to_s.should eq("test@example.com, bob@example.com")
    end
  end
  
  describe "given nil" do
    before do
      @it = EmailDetector::Detector.new(nil)
    end
    
    it "is empty" do
      @it.should be_empty
    end
  end
  
  describe "given an email list with both comma-separated and space-separated addresses" do
    before do
      @it = EmailDetector::Detector.new("billy@example.com, joe@example.com bob@example.com")
    end
    
    it "correctly identifies all the addresses" do
      @it.to_a.should eq(%w[billy@example.com joe@example.com bob@example.com])
    end
  end
  
  describe "given an email list with extraneous information (names)" do
    before do
      @it = EmailDetector::Detector.new("Billy Example <billy@example.com>\nJoe Example <joe@example.com>, Bob Example bob@example.com\n\n\n")
    end
    
    it "correctly identifies all the addresses" do
      @it.to_a.should eq(%w[billy@example.com joe@example.com bob@example.com])
    end

    it "gives feedback about parts of the input that were ignored" do
      @it.ignored.should_not be_empty
    end
    
    it "should not include feedback about whitespace, delimiter characters, or empty strings" do
      @it.ignored.should eq(['Billy Example', 'Joe Example', 'Bob Example'])
    end
  end
  
  describe "given a string with no valid email addresses" do
    it "should return the entire string as a warning" do
      @it = EmailDetector::Detector.new("punching your face")
      @it.to_a.should eq([])
      @it.ignored.should eq(["punching your face"])
    end
  end

  describe "given two email addresses concatenated" do
    it "marks the content as invalid" do
      @it = EmailDetector::Detector.new("billy@example.co.ukjoe@example.com")
      @it.to_a.should eq([])
      @it.ignored.should eq(["billy@example.co.ukjoe@example.com"])
    end
  end
  
  describe "given two email addresses separated by a comma but no space" do
    it "should correctly identify each address" do
      @it = EmailDetector::Detector.new("billy@example.com,susie@example.com")
      @it.to_a.should eq(%w[billy@example.com susie@example.com])
      @it.ignored.should be_empty
    end
  end
  
  describe "#+" do
    it "combines email lists into one" do
      result = EmailDetector::Detector.new("test@example.com, bob@example.com") + EmailDetector::Detector.new("jim@example.com, test@example.com")
      result.should eq(EmailDetector::Detector.new("test@example.com, bob@example.com, jim@example.com"))
    end
  end
end

