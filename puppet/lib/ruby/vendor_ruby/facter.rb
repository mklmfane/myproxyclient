module Facter
  if RUBY_PLATFORM == "java"
    # For JRuby, require 'facter.jar'
    begin
      require 'facter.jar'
    rescue LoadError
      raise LoadError.new('libfacter was not built with JRuby support.')
    end

    # Pass value call through to JNI interface
    def self.value(name)
      Java::ComPuppetlabs::Facter.lookup(name)
    end

    def self.search(*paths)
      # No-op; we don't support custom facts under JRuby
    end

    def self.reset()
      # No-op; we treat facts as immutable under JRuby
    end

    def self.version
      Java::ComPuppetlabs::Facter.lookup("facterversion")
    end

    def self.add(*params)
      raise 'adding facts under JRuby is not implemented.'
    end

  else
    # Simply require libfacter.so; this will define all of the Facter API
    begin
      facter_dir = ENV['FACTERDIR'] || File.join(File.expand_path("#{File.dirname(__FILE__)}"), '../../../')
      #
      # This is a cmake pre-processor check. On *nix it will end up '' == '1'
      # On windows, where we want the changes it will be '1' == '1'
      #
      # Facter requires the extra inclusion of puppet/bin as the libfacter.so
      # lib requires libraries and executables from that directory
      if '' == '1'
        ENV['PATH'] = "#{File.join(facter_dir, 'bin')}#{File::PATH_SEPARATOR}#{File.join(facter_dir, '../puppet/bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
      end
      require "#{facter_dir}/lib/libfacter.so"
    rescue LoadError
      raise LoadError, "libfacter was not found. Please make sure it was installed to the expected location.\n" + ($!.message || ''), $!.backtrace
    end
  end
end
