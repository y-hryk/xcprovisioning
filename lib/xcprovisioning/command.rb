require 'xcprovisioning'
require 'thor'
require 'terminal-table'

module Xcprovisioning
  class Command < Thor

    desc 'list', 'show provisioning list'
    def list

      # fetch provisioning profile list
      mobileDevice = MobileDevice.new()
      provisiong = mobileDevice.provisionings()

      # current provisioning profile
      current_rows = []
      provisiong.each { |profile|  
        current_rows << [ profile.name, profile.application_identifier, profile.team_name, profile.expiration_date]
      }
      current_table = Terminal::Table.new :title => "Provisioning Profile", :headings => ['name', 'application_identifier', 'team_name','expiration_date'], :rows => current_rows
      puts current_table

    end

    desc 'cleanup', 'delete duplicate provisioning profiles'
    def cleanup

      # fetch provisioning profile list
      mobileDevice = MobileDevice.new()
      remove_profiles = mobileDevice.deletion_targets()

      remove_rows = []
      remove_profiles.each { |profile|  
        remove_rows << [ profile.name, profile.application_identifier, profile.team_name, profile.expiration_date]
      }
      remove_table = Terminal::Table.new :title => "Duplicate Provisioning Profile", :headings => ['name', 'application_identifier', 'team_name','expiration_date'], :rows => remove_rows

      if !remove_rows.empty?
        puts remove_table
        while true
            print "delete duplicate provisioning profiles?[y/n]:"
	        response = STDIN.gets.chomp
	        case response
	        when /^[yY]/
	          remove_profiles.each { |profile|  
                `rm #{profile.path}`
              }
	          puts "complete"
	          return true
	        when /^[nN]/, /^$/
	          return false
	        end
        end
	  else
	  	puts 'Duplicate provisioning profile was not found.'
      end

    end
  end
end