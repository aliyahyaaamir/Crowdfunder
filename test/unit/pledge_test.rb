require 'test_helper'

class PledgeTest < ActiveSupport::TestCase

	 test "requires a user" do
		pledge = FactoryGirl.build(:pledge, user: nil)

		assert_false pledge.save
		assert_equal "can't be blank", pledge.errors[:user].first

	end

	test "requires a project" do
		pledge = FactoryGirl.build(:pledge, project: nil)

		assert_false pledge.save
		assert_equal "can't be blank", pledge.errors[:project].first
	end

	test "requires amount" do
		pledge = FactoryGirl.build(:pledge, amount: nil)

		assert_false pledge.save
		assert_equal "is not a number", pledge.errors[:amount].first
	end

	test "requires amount greater than 0" do
		pledge = FactoryGirl.build(:pledge, amount: -10)

		assert_false pledge.save
		assert_equal "must be greater than 0", pledge.errors[:amount].first
	end

	test "requires amount to be an integer" do
		pledge = FactoryGirl.build(:pledge, amount: 'abc')

		assert_false pledge.save
		assert_equal "is not a number", pledge.errors[:amount].first
	end

end
