require 'will_paginate/collection'

Grit::Commit.send(:include, CommitMethods)

class Commit < Grit::Commit

  def self.list(repository, options, conditions)
    data = raw_list_data(repository, {
      :pretty     => 'raw',
      :limit      => options[:limit],
      :offset     => options[:offset]
    }, conditions)

    self.list_from_string(repository, data)
  end

  def self.count(repository, options, conditions)
    data = raw_list_data(repository, {}, conditions)

    data.split("\n").size
  end

  def self.paginate(repository, options, conditions)
    WillPaginate::Collection.create(options[:page], options[:per_page]) do |pager|
      result = self.list(repository, options.merge({
        :limit  => pager.per_page, 
        :offset => pager.offset
      }), conditions)
      pager.replace(result)

      pager.total_entries = self.count(repository, {}, conditions) unless pager.total_entries
    end
  end

  private

  def self.raw_list_data(repository, options, conditions)
    opts = {}
    args = []

    opts.merge!(:pretty    => options[:pretty]) unless options[:pretty].blank?
    opts.merge!(:max_count => options[:limit])  unless options[:limit].blank?
    opts.merge!(:skip      => options[:offset]) unless options[:offset].blank?

    opts.merge!(:no_merges => true) if conditions[:no_merges] == '1'
    args << (conditions[:reference] || "master")
    args += Array(conditions[:include]) unless conditions[:include].blank?
    args += ["--not"] + Array(conditions[:exclude]) unless conditions[:exclude].blank?

    repository.git.run("", "rev-list", "", opts, args)
  end

end
