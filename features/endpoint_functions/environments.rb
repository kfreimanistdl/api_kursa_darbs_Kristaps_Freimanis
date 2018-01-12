require 'rest-client'
require 'test-unit'

def add_new_environment(project)
  environment_payload = { name: 'PREPROD' }.to_json

  response = post('http://apimation.com/environments',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: environment_payload)

  assert_equal(200, response.code, "Couldn't create new environment! Response : #{response}")
  response_hash = JSON.parse(response)
  environment = Environment.new(response_hash['id'], response_hash['name'])
  project.add_environment(environment)
end

def select_environment_and_add_global_variables(project)
  env = project.environments[rand(project.environments.length - 1)]
  env_id = env.environment_id
  env_name = env.environment_name

  global_variable_payload = { global_vars: [{ key: '$user', value: @test_user.email },
                                            { key: '$password', value: @test_user.password },
                                            { key: '$project_id', value: env_id }]}.to_json

  response_put = put('http://apimation.com/environments/active/' + env_id,
                     headers: {},
                     cookies: @test_user.session_cookie)
  assert_equal(204, response_put.code, "Can't select Environment! Response : #{response_put}")

  response_get = get('http://apimation.com/environments/' + env_id,
                     headers: {},
                     cookies: @test_user.session_cookie)
  assert_equal(200, response_get.code, "Can't get environment details! Response : #{response_get}")

  response_get_hash = JSON.parse(response_get)

  assert_equal(env_name, response_get_hash['name'], "Incorrect environment! Response : #{response_get}")
  assert_equal(env_id, response_get_hash['id'], "Incorrect environment! Response : #{response_get}")

  response_put_global_variables = put('http://apimation.com/environments/' + env_id,
                                      headers: { 'Content-Type' => 'application/json' },
                                      cookies: @test_user.session_cookie,
                                      payload: global_variable_payload)
  assert_equal(204, response_put_global_variables.code, "Global variables are not added! Response : #{response_put_global_variables}")
  
  response_get_global = get('http://apimation.com/environments/' + env_id,
                     headers: {},
                     cookies: @test_user.session_cookie)
  assert_equal(200, response_get_global.code, "Can't get environment details! Response : #{response_get_global}")

  response_get_hash = JSON.parse(response_get_global)

  response_get_hash['global_vars'].each do | item |
    env.add_global_variables(item)
  end
end

# def delete_global_variables(project)
#
# end

def delete_environment(project)
  env_id = project.environments[rand(project.environments.length - 1)].environment_id
  response_delete = delete('http://apimation.com/environments/' + env_id,
                           headers: {},
                           cookies: @test_user.session_cookie)
  assert_equal(204, response_delete.code, "Can't delete environment! Response : #{response_delete}")
end

