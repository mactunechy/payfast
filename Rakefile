# frozen_string_literal: true

namespace :version do
  desc 'Bump the patch version'
  task :bump_patch do
    bump_version(:patch)
  end

  desc 'Bump the minor version'
  task :bump_minor do
    bump_version(:minor)
  end

  desc 'Bump the major version'
  task :bump_major do
    bump_version(:major)
  end

  def bump_version(type)
    version_file = 'lib/payfast/version.rb'
    content = File.read(version_file)

    version = content.match(/VERSION = '(\d+)\.(\d+)\.(\d+)'/)

    if version.nil?
      puts 'Error: Could not find the version in the file!'
      exit(1)
    end

    major = version[1].to_i
    minor = version[2].to_i
    patch = version[3].to_i

    case type
    when :patch
      patch += 1
    when :minor
      minor += 1
      patch = 0
    when :major
      major += 1
      minor = 0
      patch = 0
    end

    new_version = "#{major}.#{minor}.#{patch}"
    new_content = content.gsub(/VERSION = ['"]\d+\.\d+\.\d+['"]/, "VERSION = '#{new_version}'")

    File.open(version_file, 'w') { |file| file.write(new_content) }

    puts "Version updated to #{new_version}"
  end
end
