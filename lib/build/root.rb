# Encoding: utf-8
# Copyright (c) 2013 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

require 'build'
require 'build/dependency/auto_reconfiguration'
require 'build/dependency/app_dynamics'
require 'build/dependency/groovy'
require 'build/dependency/jboss_as'
require 'build/dependency/mariadb_jdbc'
require 'build/dependency/new_relic'
require 'build/dependency/node/node'
require 'build/dependency/node/node_inner'
require 'build/dependency/openjdk/openjdk'
require 'build/dependency/openjdk/openjdk_inner'
require 'build/dependency/play_jpa_plugin'
require 'build/dependency/postgresql_jdbc'
require 'build/dependency/redis_store'
require 'build/dependency/spring_boot_cli'
require 'build/dependency/tc_server'
require 'build/dependency/tomcat'
require 'build/dependency/tomcat_lifecycle_support'
require 'build/dependency/tomcat_logging_support'
require 'thor'

module Build

  class Root < Thor

    class << self
      private

      def common_options
        option :configuration,
               desc:     'The path to the configuration file',
               aliases:  '-c',
               default:  '~/.java_buildpack_dependency_builder.yml',
               required: false

        option :version,
               desc:     'The version to publish',
               aliases:  '-v',
               required: true
      end

      def node_options
        option :tag,
               desc:     'The repository tag to build from',
               aliases:  '-t',
               required: true
      end

      def openjdk_options
        option :build_number,
               desc:     'The builder number of OpenJDK to create',
               aliases:  '-b',
               required: true

        option :tag,
               desc:     'The repository tag to build from',
               aliases:  '-t',
               required: true

        option :development,
               desc:     'Whether to build from the development repository',
               aliases:  '-d',
               type:    :boolean,
               required: false
      end
    end

    desc 'app-dynamics', 'Publish a version of AppDynamics'
    common_options

    option :latest,
           desc:    'Whether the version is the latest version of the plugin',
           aliases: '-l',
           type:    :boolean,
           default: true

    def app_dynamics
      Dependency::AppDynamics.new(options).build
    end

    desc 'auto-reconfiguration', 'Publish a version of Auto Reconfiguration'
    common_options

    def auto_reconfiguration
      Dependency::AutoReconfiguration.new(options).build
    end

    desc 'groovy', 'Publish a version of Groovy'
    common_options

    def groovy
      Dependency::Groovy.new(options).build
    end

    desc 'jboss-as', 'Publish a version of JBoss AS'
    common_options

    def jboss_as
      Dependency::JBossAS.new(options).build
    end

    desc 'mariadb-jdbc', 'Publish a version of MariaDB JDBC'
    common_options

    def mariadb_jdbc
      Dependency::MariaDbJDBC.new(options).build
    end

    desc 'node', 'Publish a version of NodeJS'
    common_options
    node_options

    option :platforms,
           desc:    'A list of the platforms the version should be built on',
           aliases: '-p',
           type:    :array,
           default: %w(centos6 lucid osx precise trusty)

    def node
      Dependency::Node.new(options).build
    end

    desc 'node-inner', 'Publish a version of NodeJS', hide: true
    common_options
    node_options

    def node_inner
      Dependency::NodeInner.new(options).build
    end

    desc 'openjdk', 'Publish a version of OpenJDK'
    common_options
    openjdk_options

    option :platforms,
           desc:    'A list of the platforms the version should be built on',
           aliases: '-p',
           type:    :array,
           default: %w(centos6 lucid precise trusty)

    def openjdk
      Dependency::OpenJDK.new(options).build
    end

    desc 'openjdk-inner', 'Publish a version of OpenJDK', hide: true
    common_options
    openjdk_options

    def openjdk_inner
      Dependency::OpenJDKInner.new(options).build
    end

    desc 'new-relic', 'Publish a version of New Relic'
    common_options

    def new_relic
      Dependency::NewRelic.new(options).build
    end

    desc 'play-jpa-plugin', 'Publish a version of the Play JPA Plugin'
    common_options

    def play_jpa_plugin
      Dependency::PlayJPAPlugin.new(options).build
    end

    desc 'postgresql-jdbc', 'Publish a version of PostgreSQL JDBC'
    common_options

    def postgresql_jdbc
      Dependency::PostgreSQLJDBC.new(options).build
    end

    desc 'redis-store', 'Publish a version of redis-store'
    common_options

    def redis_store
      Dependency::RedisStore.new(options).build
    end

    desc 'spring-boot-cli', 'Publish a version of Spring Boot'
    common_options

    def spring_boot_cli
      Dependency::SpringBootCLI.new(options).build
    end

    desc 'tc-server', 'Publish a version of tc Server'
    common_options

    def tc_server
      Dependency::TcServer.new(options).build
    end

    desc 'tomcat', 'Publish a version of Tomcat'
    common_options

    def tomcat
      Dependency::Tomcat.new(options).build
    end

    desc 'tomcat-lifecycle-support', 'Publish a version of tomcat-lifecycle-support'
    common_options

    def tomcat_lifecycle_support
      Dependency::TomcatLifecycleSupport.new(options).build
    end

    desc 'tomcat-logging-support', 'Publish a version of tomcat-logging-support'
    common_options

    def tomcat_logging_support
      Dependency::TomcatLoggingSupport.new(options).build
    end

  end

end
