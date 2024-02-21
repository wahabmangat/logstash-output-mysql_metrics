# encoding: utf-8
require "logstash/devutils/rspec/spec_helper"
require "logstash/outputs/mysql_metrics"
require "logstash/codecs/plain"
require "logstash/event"

describe LogStash::Outputs::MysqlMetrics do
  let(:pipeline_name) { "test_pipeline" }
  let(:metrics_log_path) { "/tmp/metrics_log.txt" }
  let(:plugin) { LogStash::Outputs::MysqlMetrics.new("pipeline_name" => pipeline_name, "metrics_log_path" => metrics_log_path) }
  let(:sample_event) { LogStash::Event.new("message" => "some text") }
  
  before do
    plugin.register
    # Create a metrics log file before each test
    FileUtils.touch(metrics_log_path)
  end

  describe "event processing" do
    before do
      plugin.multi_receive([sample_event])
    end

    it "increments document count after receiving an event" do
      expect(plugin.instance_variable_get(:@document_count)).to eq(1)
    end

    it "logs the pipeline metrics to the specified file" do
      expect(File.read(metrics_log_path)).to match(/Pipeline processing summary/)
    end
  end

  after do
    plugin.close
    # Clean up the metrics log file after tests
    FileUtils.rm(metrics_log_path)
  end
end
