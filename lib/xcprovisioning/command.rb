require 'thor'

module Xcprovisioning
  class Command < Thor

    desc 'list', 'show provisioning list'
    def list

      # fetch provisioning profile list
      mobileDevice = MobileDevice.new()
      provisiong = mobileDevice.provisionings()
      puts Reporter.provisioning_report(provisiong)

    end

    desc 'cleanup', 'delete duplicate provisioning profiles'
    def cleanup

      # fetch provisioning profile list
      mobileDevice = MobileDevice.new()
      remove_profiles = mobileDevice.deletion_targets()

      report = Reporter.provisioning_report(remove_profiles)
   
      if !remove_profiles.empty?
        puts report
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