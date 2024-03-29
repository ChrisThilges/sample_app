# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do

  before(:each) do
  	@attr = { :name => "Example User", :email => "user@example.com", :password => "foobar", :password_confirmation => "foobar" }
  end

  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  #it { should respond_to(:password) }
  #it { should respond_to(:password_confirmation) }

  #it { should be_valid }

  it "should create a new instance given a valid attribute" do
  	User.create!(@attr)
  end

  it "should require a name" do
  	no_name_user = User.new(@attr.merge(:name => ""))
  	no_name_user.should_not be_valid
  end

  it "should require an email address" do
  	no_email_user = User.new (@attr.merge(:email => ""))
  	no_email_user.should_not be_valid
  end

  it "should reject names that are to long" do
  	long_name = "a" * 51
  	long_name_user = User.new(@attr.merge(:name => long_name))
  	long_name_user.should_not be_valid
  end

  it "should accept valid email address" do
  	addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
  	addresses.each do |address|
  		valid_email_user = User.new(@attr.merge(:email => address))
  		valid_email_user.should be_valid
  	end
  end

  it "should reject invalid email address" do
  	addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
  	addresses.each do |address|
  		invalid_email_user = User.new(@attr.merge(:email => address))
  		invalid_email_user.should_not be_valid
  	end
  end

  it "should reject duplicate email addresses" do
  	User.create!(@attr)
  	user_with_duplicate_email = User.new(@attr)
  	user_with_duplicate_email.should_not be_valid
  end

  it "should reject email addresses identical up to case" do
  	upcased_email = @attr[:email].upcase
  	User.create!(@attr.merge(:email => upcased_email))
  	user_with_duplicate_email = User.new(@attr)
  	user_with_duplicate_email.should_not be_valid
  end
end
