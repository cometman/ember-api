require 'rails_helper'

# RSpec.describe Contact, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end
require "spec_helper"

describe Contact do
  it "should have a factory" do
    expect(FactoryGirl.build(:contact)).to be_valid
  end

  context "validations" do
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:title) }
  end
end