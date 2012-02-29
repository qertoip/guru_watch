# -*- coding: UTF-8 -*-

def require_dir( path_dir )
  Dir.glob( path_dir + '/*.rb' ).each do |file|
    require file
  end
end

def require_dirs( file_or_dir )
  Dir.glob( File.dirname( file_or_dir ) + "/*" ) do |path|
    if File.directory?( path )
      require_dir( path )
    end
  end
end

def require_siblings( path_to_file )
  Dir.glob( File.dirname( path_to_file ) + '/*.rb' ).each do |path|
    require path unless path == path_to_file
  end
end
