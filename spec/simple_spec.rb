require 'set'
require 'spec/spec_helper'

describe "simple esi attribute" do

  it "should do nothing" do
    EsiAttributeLanguage::SimpleGrammar.parse("my test string").execute(nil).should == 'my test string'
  end

  it "should interpolate a variable" do
    EsiAttributeLanguage::SimpleGrammar.parse("$(TESTING)").execute({:TESTING => 'hey you'}).should == 'hey you'
  end

  it "should interpolate a variable on the left" do
    EsiAttributeLanguage::SimpleGrammar.parse("$(TESTING) my test string").execute({:TESTING => 'hey you'}).should == 'hey you my test string'
  end

  it "should interpolate a variable on the right" do
    EsiAttributeLanguage::SimpleGrammar.parse("my test string $(TESTING)").execute({:TESTING => 'hey you'}).should == 'my test string hey you'
  end

  it "should interpolate several variables" do
    EsiAttributeLanguage::SimpleGrammar.parse("my test string $(TESTING) and one more $(TESTING2) and thats it").execute({:TESTING => 'hey you', :TESTING2 => 'why bother'}).should == 'my test string hey you and one more why bother and thats it'
  end

  it "should do a hash lookup (with quotes)" do
    EsiAttributeLanguage::SimpleGrammar.parse("my test string $(TESTING{'testing'}) and one more").execute({:TESTING => {'testing' => 'hey'}}).should == 'my test string hey and one more'
  end

  it "should do a hash lookup (without quotes)" do
    EsiAttributeLanguage::SimpleGrammar.parse("my test string $(TESTING{testing}) and one more").execute({:TESTING => {'testing' => 'hey'}}).should == 'my test string hey and one more'
  end

end