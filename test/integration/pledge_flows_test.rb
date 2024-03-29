require 'test_helper'

class PledgeFlowsTest < ActionDispatch::IntegrationTest

	setup do
		@project = FactoryGirl.create :project
	end

	test "requires authenticated user" do
		visit project_path(@project)

		click_link 'Back This Project'

		assert_equal new_session_path, current_path
		assert page.has_content?("Please login first.")
	end

	test "authenticated user can pledge valid amount" do
		user = setup_signed_in_user

		visit project_path(@project)
		click_link 'Back This Project'

		assert_equal new_project_pledge_path(@project), current_path
		assert_equal 0, Pledge.count

		fill_in 'pledge[amount]', with: 100
		click_button 'Pledge Now'

		assert_equal project_path(@project), current_path
		assert page.has_content?("Thanks for pledging")

		assert pledge = Pledge.order(:id).last
		assert_equal user, pledge.user
		assert_equal @project, pledge.project
		assert_equal 100, pledge.amount

		assert_equal [@project.user.email], last_email.to
	end

end
