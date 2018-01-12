require 'rest-client'
require 'test-unit'

def login_positive
  login_payload = { login: @test_user.email,
                    password: @test_user.password }.to_json

  response = post('https://www.apimation.com/login',
                  headers: { 'Content-Type' => 'application/json' },
                  cookies: {},
                  payload: login_payload)
  # Check if 200 OK is received
  assert_equal(200, response.code, "Login Failed! Response : #{response}")

  response_hash = JSON.parse(response)

  assert_equal(@test_user.email, response_hash['email'], "Incorrect email")

  @test_user.set_session_cookie(response.cookies)
  @test_user.set_user_id(response_hash['user_id'])
end

def check_personal_info
  response_user = get('https://apimation.com/user',
                      headers: {},
                      cookies: @test_user.session_cookie)
  assert_equal(200, response_user.code, "Unable to login!")
  response_hash = JSON.parse(response_user)

  assert_equal(@test_user.email, response_hash['email'], "Incorrect email")
  assert_equal(@test_user.email, response_hash['login'], "Incorrect login")
  assert_equal(@test_user.user_id, response_hash['user_id'], "Incorrect user id")
end