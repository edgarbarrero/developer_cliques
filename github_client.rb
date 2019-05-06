# frozen_string_literal: true

require 'github_api'

class GithubClient

  def self.find_connections(handle:, handle_list:)
    organizations = developer_organizations(handle)
    all_members = organization_members(organizations)
    (all_members - [handle]) & handle_list
  end

  def self.developer_organizations(handle)
    organizations = Github.organizations.list user: handle
    organizations.map(&:login)
  end

  def self.organization_members(organizations)
    organizations.each_with_object([]) do |org, arr|
      members = Github.orgs.members.list org, public: true
      arr << members.map(&:login)
    end.flatten
  end
end
