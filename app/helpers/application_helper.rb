module ApplicationHelper

def helper_path

	true if current_page?(controller: 'projects', action: 'show')
end
end
