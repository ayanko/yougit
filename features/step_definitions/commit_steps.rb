Then /^I should see commits:$/ do |table|
  response.should have_tag("table") do |node|
    table.hashes.each do |hash|
      node.should have_tag("td", hash['message'])
    end
  end
end

Then /^I should NOT see commits:$/ do |table|
  table.hashes.each do |hash|
    response.should_not have_tag("td", hash['message'])
  end
end
