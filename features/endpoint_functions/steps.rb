require 'rest-client'
require 'test-unit'

def add_login_test(project)
  env = project.environments[rand(project.environments.length - 1)]
  login_username = env.global_variables[0]['key'].to_s
  login_password = env.global_variables[1]['key'].to_s

  step_payload = { name: 'Login',
                 description: '',
                 request: { method: 'POST',
                    url: 'https://apimation.com/login',
                    type: 'raw',
                    body:  "{\"login\": \"#{login_username}\",\"password\": \"#{login_password}\"}",
                 binaryContent: { value: '',
                                filename: '' },
                 urlEncParams: [{ name: '',
                                 value: '' }],
                 formData: [{ type: 'text',
                             value: '',
                             name: '',
                             filename: '' }],
                  headers: [{ name: 'Content-Type',
                             value: 'application/json' }],
                  greps: [],
                  auth: { type: 'noAuth',
                  data: {} } },
                  paste: false,
                  collection_id: project.collection[0].collection_id }.to_json
  
    response = post('http://apimation.com/steps',
                    headers: { 'Content-Type' => 'application/json' },
                    cookies: @test_user.session_cookie,
                    payload: step_payload)
    assert_equal(200, response.code, "Couldn't add step! Response : #{response}")
  end

  def add_set_active_project_test(project)
    env = project.environments[rand(project.environments.length - 1)]
    active_project = env.global_variables[2]['key'].to_s
    cookie = @test_user.session_cookie['dancer.session']

    step_payload = { name: 'Set Active project',
                     description: '',
                     request: { method: 'PUT',
                                url: "http://apimation.com/environments/active/#{active_project}",
                                type: 'raw',
                     binaryContent: { value: '',
                                      filename: '' },
                     urlEncParams: [{ name: '',
                                      value: '' }],
                     formData: [{ type: 'text',
                                  value: '',
                                  name: '',
                                  filename: '' }],
                     headers: [{ name: 'Cookie',
                                 value: "dancer.session=#{cookie}"}],
                     greps: [],
                     auth: { type: 'noAuth',
                     data: {} } },
                     paste: false,
                     collection_id: project.collection[1].collection_id }.to_json

  response = post('http://apimation.com/steps',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: @test_user.session_cookie,
                  payload: step_payload)
                  
  assert_equal(200, response.code, "Couldn't add step! Response : #{response}")
  end