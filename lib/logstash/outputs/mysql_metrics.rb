# encoding: utf-8
require 'logstash/outputs/base'
require 'logstash/namespace'
require 'fileutils'

class LogStash::Outputs::MysqlMetrics < LogStash::Outputs::Base
  config_name 'mysqlMetrics'

  # Configuration options
  config :pipeline_name, :validate => :string
  config :metrics_log_path, :validate => :string  # Path to the file where metrics will be logged

  public
  def register
    # Initialize counters and flags
    @document_count = 0
    @errors = false
    @start_time = nil # Will be set with the first event
    @stop_time = nil   # Updated with every batch processed
    @mutex = Mutex.new
    @logger.info("Plugin initialized")
    # Ensure the log directory exists
    FileUtils.mkdir_p(File.dirname(@metrics_log_path))
    @metrics_file = File.open(@metrics_log_path, "a")
  end

  public
  def multi_receive(events)
    @mutex.synchronize do
      @start_time ||= Time.now # Set start time with the first batch
      @stop_time = Time.now     # Always update end time with the current batch
    end
  
    # Thread-safe increment of document count
    @mutex.synchronize { @document_count += events.size }
    events.each do |event|
      begin
        # Placeholder for actual event processing logic
        @logger.debug("Event processed", :pipeline_name => @pipeline_name, :event_data => event.to_hash)
      rescue => e
        @mutex.synchronize { @errors = true }
        @logger.error("Error processing event", :exception => e.message)
      end
    end
  end

  def close
    duration = @stop_time - @start_time
    # Log the metrics at plugin closure
    @logger.info("Pipeline processing summary",
                 :pipeline_name => @pipeline_name,
                 :document_count => @document_count,
                 :errors => @errors,
                 :duration => duration,
                 :start_time => @start_time,
                 :stop_time => @stop_time)
    # Write the same metrics to the custom log file
    @metrics_file.puts("Pipeline processing summary: #{{
      pipeline_name: @pipeline_name,
      document_count: @document_count,
      errors: @errors,
      duration: duration,
      start_time: @start_time,
      stop_time: @stop_time
    }.to_json}")
    @metrics_file.close
  end
end
