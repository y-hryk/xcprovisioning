require 'time'

module Xcprovisioning

   class MobileDevice
		def initialize()
		end

		public
		def provisionings()
			unless @provisionings
				@provisionings = []
				provisioning_data_root = File.expand_path('~/Library/MobileDevice/Provisioning\ Profiles/')
				provisioning_paths = Dir.glob("#{provisioning_data_root}/*.mobileprovision").map { |profile| profile }

				@provisionings = provisioning_paths.map { |path| 

					provisioning_pash = File.join(provisioning_data_root, "#{File.basename(path)}")
					Provisioning.new(provisioning_pash)
				}
			end

			# 作成日でソート
			@provisionings.sort! {|a, b| a.creation_date <=> b.creation_date }
			# 名前でソート
			@provisionings.sort! {|a, b| a.name <=> b.name }
		end

		def deletion_targets()
          
          appId_group = provisionings().group_by do |profile|
            profile.application_identifier
          end

          # p appId_group
          remove_profiles = []
          appId_group.each_value {|val|

          if val.count > 1
             recent_profile = val.max_by {|value| value.creation_date}
             val.delete(recent_profile)
             val.each { |profile|  
               if profile.name == recent_profile.name
                 remove_profiles << profile
                 remove_profiles << profile
               end
             }
          end
          }

          expariment_profile = []
          now_date = Time.now
          provisionings().each { |profile| 
          	date = Time.strptime(profile.expiration_date.to_s,"%Y-%m-%dT%H:%M:%S%z")
            if date < now_date 
              expariment_profile << profile
            end

          }

          profiles = remove_profiles.concat(expariment_profile).uniq {|profile| profile.file_name }
          
		end

		def parse_date_str(date_str)
  			(Chronic.parse(date_str) || Date.parse(date_str)).to_date
		end
   end
end
