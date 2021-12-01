require "pry"

Dir.glob(File.expand_path("../lib/*.rb", __FILE__)).sort.each { |r| require r }
