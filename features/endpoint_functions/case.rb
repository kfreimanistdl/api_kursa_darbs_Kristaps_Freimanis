require 'rest-client'
require 'test-unit'

def create_new_test(project)

    login_url = project.steps[0]['request']['url']
    login_step_name = project.steps[0]['request']['name']
    login_step_body = project.steps[0]['request']['body']
    active_name = project.steps[1]['request']['name']
    active_url = project.steps[1]['request']['url']

    payload = { name: "Set active project",
                description: "Kursa Darbs",
                request: {
                    requests: [{
                                step_name: login_step_name,
                                url: login_url,
                                body: login_step_body,
                                formData: [{
                                            type: "text",
                                            value: "",
                                            name: "",
                                            filename: ""
                                            }],
                                urlEncParams: [{
                                            name: "",
                                            value: ""
                                                }],
                                binaryContent: {
                                            value: "",
                                            filename: ""
                                            },
                                type: "raw",
                                headers: [{
                                        name: "Content-Type",
                                        value: "application/json"
                                          }],
                                method: "POST",
                                greps: [{
                                        type: "json",
                                        expression: "",
                                        varname: ""
                                        }],
                                asserts: []},
                            {
                                step_name: active_name,
                                url: active_url,
                                formData: [{
                                        type: "text",
                                        value: "",
                                        name: "",
                                        filename: ""
                                            }],
                                urlEncParams: [{
                                        name: "",
                                        value: ""
                                                }],
                                binaryContent: {
                                        value: "",
                                        filename: ""
                                                },
                                type: "raw",
                                headers: [{
                                        name: "Cookie",
                                        value: @test_user.session_cookie
                                            }],
                                method: "PUT",
                                greps: [{
                                        type: "json",
                                        expression: "",
                                        varname: ""
                                        }],
                                asserts: []}],
                    vars: [{
                        name: "",
                        value: ""
                            }],
          assertWarn: 1}}.to_json

    response = post('http://apimation.com/cases',
                     headers: { 'Content-Type' => 'application/json' },
                     cookies: @test_user.session_cookie,
                     payload: payload)

    response_hash = JSON.parse(response)
    assert_equal(200, response.code, "Couldn't add case! Response : #{response_hash}")
    assert_equal("Set active project", response_hash['name'], "Incorrect case name! Response : #{response_hash}")
    assert_equal("Kursa Darbs", response_hash['description'], "Incorrect case description! Response : #{response_hash}")
    new_case = Case.new(response_hash['case_id'], response_hash['name'], response_hash['description'])
    project.add_cases(new_case)
end

def delete_all_cases(project)
    project.case.each do | item |
        response_delete = delete('http://apimation.com/cases/' + item.case_id,
                               headers: {},
                               cookies: @test_user.session_cookie)
        assert_equal(204, response_delete.code, "Can't delete case! Response : #{response_delete}")
      end
end