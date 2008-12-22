require 'digest/md5'

namespace :mephisto do
  desc "Export all sites, sections, users, articles, and comments as RAILS_ROOT/public/mephisto_export_<timestamp>_<obfuscation>.xml"
  task :export => :environment do
    xml = Site.find(:all).to_xml(:include => {:sections => {},
                                              :members => {},
                                              :articles => {:include => { :comments => {},
                                                                          :sections => {:only => :id}}}})
    t = Time.now.utc
    md5 = Digest::MD5.hexdigest([t, rand(0), $$].join)
    filename = 'mephisto_export_' + t.strftime('%Y%m%d%H%M%S') + '_' + md5[0..6] + '.xml'
    full_path = File.join(RAILS_ROOT, 'public', 'exports', filename)
    File.makedirs File.dirname(full_path)
    File.open(full_path, 'w+') do |file|
      file.puts xml
    end
    puts "Exported data to:\n#{full_path}\n"
  end
  
  namespace :export do
    desc "Delete exports older than the latest number of exports designated by ENV['KEEP'] (default 10)"
    task :cleanup do
      
      num = ENV['KEEP'].to_i || 10
      num = [0,num].max
      files = Dir.glob(File.join(RAILS_ROOT, 'public', 'exports', '*.xml')).sort
      to_delete = files[0..-(num + 1)]
      to_delete.each do |file|
        File.delete(file)
      end
      remaining = files - to_delete
      singular = remaining.size == 1
      puts "Deleted #{to_delete.size} export files. #{remaining.size} export#{singular ? '' : 's'} remain#{singular ? 's' : ''}#{remaining.empty? ? '.' : ':'}"
      puts (remaining.join("\n")) unless remaining.empty?
    end
  end
end