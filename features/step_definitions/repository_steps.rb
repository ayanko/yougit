Given /^repositories:$/ do |table|
  table.hashes.each do |hash|
    create_repo(hash['name'])
  end
end
