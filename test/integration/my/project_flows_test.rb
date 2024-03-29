require 'test_helper'

class My::ProjectFlowsTest < ActionDispatch::IntegrationTest

	test "lists only my projects" do
		me = setup_signed_in_user
		other_user = FactoryGirl.create :user

		3.times { FactoryGirl.create :project, user: me }
		2.times { FactoryGirl.create :project, user: other_user, title: "Other Dude's Project" }

		visit '/my/projects'

		page.assert_selector('div.project', count: 3)
		assert page.has_no_content?("other Dude's Project")
	end

	test "can edit my project" do
		me = setup_signed_in_user

		project = FactoryGirl.create :project, user: me, title: "My Project"

		visit edit_my_project_path(project)

		fill_in 'project[title]', with: "It is really my project"
		click_button 'Update Project'

		assert_equal my_projects_path, current_path
		assert page.has_content?("It is really my project")
	end

	test "cannot edit someone else's project" do
		me = setup_signed_in_user

		other_user = FactoryGirl.create :user
		project = FactoryGirl.create :project, user: other_user, title: "other Dude's Project"

		visit edit_my_project_path(project)

		assert has_content?("doesn't exist")
	end

	test "successful creation of project makes it public right away" do
		me = setup_signed_in_user

		project = FactoryGirl.build(:project, user: me)

		visit 'my/projects/new'

		fill_in 'project[title]', with: "Test Project"
		fill_in 'project[teaser]', with: "Test Project Teaser"
		fill_in 'project[description]', with: "Test Project Description"
		fill_in 'project[goal]', with: "12000"

		click_button 'Publish Project'

		assert_equal my_projects_path, current_path
	end

	test "navigation" do
		user = setup_signed_in_user

		visit '/'

		find('.navbar ul').click_link('My Projects')
		assert_equal my_projects_path, current_path

		assert_equal "My Projects", find('.navbar ul li.active a').text
		page.assert_selector '.navbar ul li.active a', count: 1

		click_link "New Project"
		assert_equal new_my_project_path, current_path
		assert_equal "My Projects", find('.navbar ul li.active a').text
	end
end
