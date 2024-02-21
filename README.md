# Logstash Output Plugin for MySQL Metrics

This is a plugin for [Logstash](https://github.com/elastic/logstash).

It captures and logs metrics about MySQL pipeline processing to a specified file. This enables monitoring and visualization of Logstash performance when interfacing with MySQL, facilitating analysis outside Logstash. It's open source under the Apache 2.0 license.

## Installation

To install this plugin on your Logstash instance, use the Logstash-plugin command:

```sh
bin/logstash-plugin install logstash-output-mysql_metrics
```

## Configuration

Here's an example configuration for the plugin within your Logstash pipeline:

```ruby
output {
  mysql_metrics {
    pipeline_name => "MySQL_to_Elasticsearch"
    metrics_log_path => "/path/to/metrics_log_file.log"
  }
}
```

### Parameters

#### pipeline_name:

Identifies the pipeline for logging.

#### metrics_log_path:

Specifies the path to the log file where metrics will be written.

### Usage

After installation and configuration, the plugin automatically logs metrics about the MySQL pipeline processing at the specified log path. Metrics include pipeline start and stop times, duration, document count, and any errors encountered.

To analyze the data, you can use tools like Grafana to visualize the metrics by reading the log file, or implement custom processing scripts to analyze the data further.

## Need Help?

Need help? Try #logstash on freenode IRC or the https://discuss.elastic.co/c/logstash discussion forum.

## Developing

### Prerequisites

#### JRuby:

Install [JRuby](https://www.jruby.org/getting-started) (follow the official guide).

#### Logstash:

Ensure Logstash is installed. For Docker users, pull the official image with docker pull docker.elastic.co/logstash/logstash:8.11.0.

### 1. Plugin Developement and Testing

#### Code

- To get started, you'll need JRuby with the Bundler gem installed.

- Create a new plugin or clone and existing from the GitHub [logstash-plugins](https://github.com/logstash-plugins) organization. We also provide [example plugins](https://github.com/logstash-plugins?query=example).

- Install dependencies

```sh
bundle install
```

#### Test

- Update your dependencies

```sh
bundle install
```

- Run tests

```sh
bundle exec rspec
```

### 2. Running your unpublished Plugin in Logstash

#### 2.1 Run in a local Logstash clone

- Edit Logstash `Gemfile` and add the local plugin path, for example:

```ruby
gem "logstash-output-mysql_metrics", :path => "/your/local/logstash-output-mysql_metrics"
```

- Install plugin

```sh
bin/logstash-plugin install --no-verify
```

- Run Logstash with your plugin by specifying your configuration file. Assuming your configuration is in path/to/your/config.conf

```sh
bin/logstash -f /path/to/your/config.conf
```

At this point any modifications to the plugin code will be applied to this local Logstash setup. After modifying the plugin, simply rerun Logstash.

#### 2.2 Run in an installed Logstash

You can use the same **2.1** method to run your plugin in an installed Logstash by editing its `Gemfile` and pointing the `:path` to your local plugin development directory or you can build the gem and install it using:

- Build your plugin gem

```sh
gem build logstash-output-mysql_metrics.gemspec
```

- Install the plugin from the Logstash home

```sh
bin/logstash-plugin install /your/local/plugin/logstash-output-mysql_metrics-0.1.0.gem
```

- Start Logstash and proceed to test the plugin

## Contributing

All contributions are welcome: ideas, patches, documentation, bug reports, complaints, and even something you drew up on a napkin.

Programming is not a required skill. Whatever you've seen about open source and maintainers or community members saying "send patches or die" - you will not see that here.

It is more important to the community that you are able to contribute.

For more information about contributing, see the [CONTRIBUTING](https://github.com/elastic/logstash/blob/main/CONTRIBUTING.md) file.
