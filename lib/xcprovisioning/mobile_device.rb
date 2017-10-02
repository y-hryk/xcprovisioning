
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
   end
end
