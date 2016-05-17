When(/^I run a tagged scenario$/) do
  $stdout.puts 'Hello, Tags!'
end

Then(/^I know the test set is running without error$/) do
  true
end

When(/^I use the application$/) do
  (visit MioLoginPage)
end

Then(/^it is available to me$/) do
  expect(@browser.text_field(id: 'j_username').present?).to be_truthy
end
