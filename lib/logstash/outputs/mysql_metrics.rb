# encoding: utf-8
require "logstash/outputs/base"

# An mysql_metrics output that does nothing.
class LogStash::Outputs::MysqlMetrics < LogStash::Outputs::Base
  config_name "mysql_metrics"

  public
  def register
  end # def register

  public
  def receive(event)
    return "Event received"
  end # def event
end # class LogStash::Outputs::MysqlMetrics
