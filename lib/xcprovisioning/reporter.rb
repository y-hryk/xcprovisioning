require 'terminal-table'

module Xcprovisioning
    class Reporter
      class << self
        def provisioning_report(provisioning)
        	current_rows = []
    		provisioning.each { |profile|  
        		current_rows << [ profile.name, profile.application_identifier, profile.team_name, profile.expiration_date]
      		}
     		current_table = Terminal::Table.new :title => "Provisioning Profile", :headings => ['name', 'application_identifier', 'team_name','expiration_date'], :rows => current_rows
        end
      end
    end
end