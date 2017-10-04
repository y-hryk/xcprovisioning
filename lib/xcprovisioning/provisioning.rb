require 'plist'
module Xcprovisioning
	class Provisioning

		attr_accessor :path, :name, :creation_date, :provisioning_path, :application_identifier, :team_name, :uuid , :file_name, :expiration_date

		def initialize(path)
			profile = %x{ security cms -D -i #{path} 2> /dev/null}
			profile_hash = Plist::parse_xml(profile)
			@path = path
			@name = profile_hash['Name']
			@uuid = profile_hash['UUID']
			@file_name = "#{@uuid}.mobileprovision"
			@creation_date = profile_hash['CreationDate']
			@expiration_date = profile_hash['ExpirationDate']
			@application_identifier = profile_hash['Entitlements']['application-identifier']
			@team_name = profile_hash['TeamName']
		end

	end
end