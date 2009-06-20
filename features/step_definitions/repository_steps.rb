Given /^repositories:$/ do |table|
  table.hashes.each do |hash|
    create_repo(hash['name'])
  end
end

Given /^repository with "([^\"]*)" name$/ do |name|
  @repository = create_repo(name)
end

Given /^repository has branches:$/ do |table|
  table.hashes.each do |hash|
    @repository.create_branch(hash['name'])
  end
end

