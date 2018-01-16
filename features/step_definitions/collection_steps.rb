When(/^I add ([^"]*) collection$/) do | name |
    collection = create_new_collection(name)
    @project.add_collections(collection)
end

When(/^I add successfull Login request/) do
    add_login_test(@project)
end

When(/^I add successfull Active project request/) do
    add_set_active_project_test(@project)
end