When(/^I find existing project$/) do
  @project = find_active_project
end

When(/^I select existing project$/) do
  select_existing_project(@project)
end

When(/^I add PREPROD environment$/) do
  add_new_environment(@project)
end

When(/^I add 3 global variables to environment$/) do
  select_environment_and_add_global_variables(@project)
end