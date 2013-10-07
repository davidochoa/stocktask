Given(/^The web applications runs on Heroku$/) do
  pending # express the regexp above with the code you wish you had
end

When /^I open the application url$/ do
  visit root_path
end

Then /^I must see the front page with application title "(.*)"$/ do |title|
  expect(page).to have_title title
end

When /^I press button "Enter new stock"$/ do
  click_link("Enter new stock")
end

Then /^I must see the page with title "(.*?)"$/ do |title|
  expect(page).to have_title title
end

Then /^I must be able to enter the following values:$/  do |table|
  table.raw.each do |row|
    field = 'stock[' + row[0] + ']'
    fill_in field, :with => row[1]
  end
end

And /^I press button "Calculate"$/ do
  click_button("Calculate")
end

And /^I must see the original input data:$/ do |table|
  rows = find('table.stock-data').all('tr')
  table_raw = table.raw
  table_page = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  expect(table_raw).to eq(table_page)
end

And /^list of stock values for each year:$/ do |table|
  rows = find('table.stock-values').all('tr')
  table_raw = table.raw
  table_page = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  table_page.slice!(0)
  expect(table_raw).to eq(table_page)
end

And /^the stock growth is shown as a visual graph$/ do
  page.should have_selector('#chart-1')
end

Then /^the stock data must be saved into the database for later review$/ do
  Stock.where(name: 'Company XYZ')
end

When /^I click "Back"$/ do
  page.evaluate_script('window.history.back()')
end

Given /^the system has already calculated stocks$/ do |stocks|
  !Stock.create(stocks.hashes)
end

And /^I must see a table of saved stocks:$/ do |table|
  rows = find('table').all('tr')
  table_raw = table.raw
  table_page = rows.map { |r| r.all('th,td').map { |c| c.text.strip } }
  table_raw.each_with_index do |row, i|
    expect(row).to eq(table_page [i].slice(0,5))
  end
end

When /^I click on the calculated line "(.*?)"$/ do |company_link|
  click_link(company_link)
end

Then /^I must see the already calculated data$/ do
  page.should have_selector('table')
end