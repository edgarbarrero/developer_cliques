# frozen_string_literal: true

require 'github_api'

class GithubClient
  class << self
    def find_connections(handle:, handle_list:)
      organizations = developer_organizations(handle)
      all_members = organization_members(organizations)
      (all_members - [handle]) & handle_list
    end

    private

    def developer_organizations(handle)
      organizations = Github.organizations.list user: handle
      organizations.map(&:login)
    end

    def organization_members(organizations)
      organizations.each_with_object([]) do |org, arr|
        members = Github.orgs.members.list org, public: true
        arr << members.map(&:login)
      end.flatten
    end
  end
end
