require 'rest-client'
require 'test-unit'

def find_active_project
  # return all projects for particular user
  response_find_existing_project = get('http://apimation.com/projects',
                                       headers: {},
                                       cookies: @test_user.session_cookie)
  assert_equal(200, response_find_existing_project.code, "Can't retreive project list! Response : #{response_find_existing_project}")
  response_hash = JSON.parse(response_find_existing_project)
  random_index_in_response_hash = rand(response_hash.length)
  
  # set project name and id that will be used for further tests
  project = Project.new(response_hash[random_index_in_response_hash]['id'], response_hash[random_index_in_response_hash]['name'])
  project
end

def select_existing_project(project)
  response_select_existing_project = put('http://apimation.com/projects/active/' + project.project_id,
                                         headers: {},
                                         cookies: @test_user.session_cookie)
  assert_equal(204, response_select_existing_project.code, "Existing project can't be selected! Response : #{response_select_existing_project}")
end