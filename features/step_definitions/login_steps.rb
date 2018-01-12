Given(/^I am logged in apimation.com as a regular user$/) do
  login_positive
  check_personal_info
end