require 'test_helper'

class ProjectFlowsTest < ActionDispatch::IntegrationTest

 test "browsing projects" do
	project1 = FactoryGirl.create(:project, :title => "Project 1")
	project2 = FactoryGirl.create(:project, :title => "Project 2")
	project3 = FactoryGirl.create(:project, :title => "Project 3")

	visit "/projects"

	assert_equal projects_path, current_path

	assert page.has_content?('Listing projects')


	assert page.has_content?('Project 1')
	assert page.has_content?('Project 2')
	assert page.has_content?('Project 3')

	click_link 'Project 1'

	assert_equal project_path(project1), current_path

	assert find('h1:first').has_content? project1.title

 end

 test "navigation" do

 	project1 = FactoryGirl.create(:project, :title => "Project 1")

 	visit "/"

 	assert_equal root_path, current_path

 	assert_equal "Home", find('.navbar ul li.active a').text

 	find('.navbar ul').click_link('Projects')

 	assert_equal projects_path, current_path

 	assert_equal "Projects", find('.navbar ul li.active a').text

 	click_link 'Project 1'
 	assert_equal "Projects", find('.navbar ul li.active a').text
 end

end
