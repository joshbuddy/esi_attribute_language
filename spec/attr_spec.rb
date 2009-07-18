require 'set'
require 'spec/spec_helper'

describe "esi attribute" do

  it "should recognize a simple number" do
    EsiAttributeLanguage::Grammar.parse("1").execute(nil).should == 1
  end

  it "should recognize a simple addition" do
    EsiAttributeLanguage::Grammar.parse("2+3").execute(nil).should == 5
  end

  it "should ignore wacky whitespace" do
    EsiAttributeLanguage::Grammar.parse("2 *  3").execute(nil).should == 6
  end

  it "should recognize a simple multiplication" do
    EsiAttributeLanguage::Grammar.parse("2*3").execute(nil).should == 6
  end

  it "should do a simple lookup" do
    EsiAttributeLanguage::Grammar.parse("$(TEST_HASH)").execute({:TEST_HASH => 'value'}).should == 'value'
  end

  it "should do a hash lookup" do
    EsiAttributeLanguage::Grammar.parse("$(TEST_HASH{'key'})").execute({:TEST_HASH => {'key' => 'value'}}).should == 'value'
    EsiAttributeLanguage::Grammar.parse("$(TEST_HASH{key})").execute({:TEST_HASH => {'key' => 'value'}}).should == 'value'
  end

  it "should do a set lookup" do
    EsiAttributeLanguage::Grammar.parse("$(TEST_SET{'value'})").execute({:TEST_SET => Set.new(['value'])}).should == true
  end

  it "should do a string literal" do
    EsiAttributeLanguage::Grammar.parse("$('testing')").execute(nil).should == 'testing'
  end

  it "should do a string with a space in it" do
    EsiAttributeLanguage::Grammar.parse("$('testing one more')").execute(nil).should == 'testing one more'
  end

  it "should do a string with an escaped quote in it" do
    EsiAttributeLanguage::Grammar.parse("$('testing \\'one\\' more')").execute(nil).should == 'testing \'one\' more'
  end

  it "should do a default lookup depending on the success of the first lookup" do
    EsiAttributeLanguage::Grammar.parse("$(TEST_HASH|'testing')").execute({:TEST_HASH => 'value'}).should == 'value'
    EsiAttributeLanguage::Grammar.parse("$(TEST_HASH|'testing')").execute({:TEST_HASH2 => 'value'}).should == 'testing'
  end

  it "should support ==" do
    EsiAttributeLanguage::Grammar.parse("'test' == 'test'").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("5 == 5").execute(nil).should == true
  end

  it "should support !=" do
    EsiAttributeLanguage::Grammar.parse("'test' != 'test2'").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("'test' != 'test'").execute(nil).should == false
  end

  it "should support <=" do
    EsiAttributeLanguage::Grammar.parse("5 <= 7").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("6 <= 5").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("6 <= 6").execute(nil).should == true
  end

  it "should support >=" do
    EsiAttributeLanguage::Grammar.parse("50 >= 47").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("600 >= 5000").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("6000 >= 6000").execute(nil).should == true
  end

  it "should support <" do
    EsiAttributeLanguage::Grammar.parse("5 < 7").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("6 < 5").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("6 < 6").execute(nil).should == false
  end

  it "should support >" do
    EsiAttributeLanguage::Grammar.parse("50 > 47").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("600 > 5000").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("6000 > 6000").execute(nil).should == false
  end

  it "should support !" do
    EsiAttributeLanguage::Grammar.parse("!(5 < 7)").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("!(6 == 5)").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("!(6 < 6)").execute(nil).should == true
  end

  it "should support &" do
    EsiAttributeLanguage::Grammar.parse("(5 < 7) & (1 ==1)").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("(5 > 7) & (1 ==1)").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("(5 < 7) & (1 !=1)").execute(nil).should == false
    EsiAttributeLanguage::Grammar.parse("(5 > 7) & (1 !=1)").execute(nil).should == false
  end

  it "should support |" do
    EsiAttributeLanguage::Grammar.parse("(5 < 7) | (1 ==1)").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("(5 > 7) | (1 ==1)").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("(5 < 7) | (1 !=1)").execute(nil).should == true
    EsiAttributeLanguage::Grammar.parse("(5 > 7) | (1 !=1)").execute(nil).should == false
  end

end