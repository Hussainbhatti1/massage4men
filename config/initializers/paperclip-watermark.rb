# https://raw.githubusercontent.com/ng/paperclip-watermarking-app/master/lib/paperclip_processors/watermark.rb
module Paperclip
  class Watermark < Processor
    # Handles watermarking of images that are uploaded.    
    attr_accessor :current_geometry, :target_geometry, :format, :whiny, :convert_options, :watermark_path, :overlay, :position
    
    def initialize file, options = {}, attachment = nil
       super
       geometry          = options[:geometry]
       @file             = file
       @crop             = geometry[-1,1] == '#'
       @target_geometry  = Geometry.parse geometry
       @current_geometry = Geometry.from_file @file
       @convert_options  = options[:convert_options]
       @whiny            = options[:whiny].nil? ? true : options[:whiny]
       @format           = options[:format]
       @watermark_path   = options[:watermark_path]
       @position         = options[:position].nil? ? "SouthEast" : options[:position]
       @overlay          = options[:overlay].nil? ? true : false
       @current_format   = File.extname(@file.path)
       @basename         = File.basename(@file.path, @current_format)
     end
     
     # TODO: extend watermark
     
     # Returns true if the +target_geometry+ is meant to crop.
      def crop?
        @crop
      end

      # Returns true if the image is meant to make use of additional convert options.
      def convert_options?
        not @convert_options.blank?
      end

      # Performs the conversion of the +file+ into a watermark. Returns the Tempfile
      # that contains the new image.
      def make
        dst = Tempfile.new([@basename, @format].compact.join("."))
        dst.binmode

        params = []

        if watermark_path
          # Target geometry is ~7.5% of the resized (target) image height 
          watermark_width = "x#{(0.075 * @target_geometry.height).round}"          
        
          command = "composite"
          params << [
            "-gravity #{@position} -geometry +5+5",
            "\\( '#{watermark_path}' -resize #{watermark_width} \\)",
            "\\( '#{File.expand_path(@file.path)}' #{transformation_command} \\)",
            tofile(dst)]
          else
            command = "convert"
            params << fromfile
            params << transformation_command
            params << tofile(dst)
          end
          
          begin
            Paperclip.run(command, params.join(' '))
          rescue ArgumentError, Cocaine::CommandLineError
            raise Paperclip::Error.new("There was an error processing the watermark for #{@basename}") if @whiny
          end




        dst
      end

      def fromfile
        File.expand_path(@file.path)
        # "\"#{ File.expand_path(@file.path) }[0]\""
      end

      def tofile(destination)
        "\"#{ File.expand_path(destination.path) }[0]\""
      end    

      def transformation_command
        scale, crop = @current_geometry.transformation_to(@target_geometry, crop?)
        trans = "-resize \"#{scale}\""
        trans << " -crop \"#{crop}\" +repage" if crop
        trans << " #{convert_options}" if convert_options?
        trans
      end


  end

end