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

require 'spec_helper'
require 'console_helper'
require 'build/dependency/auto_reconfiguration'
require 'build/dependency/app_dynamics'
require 'build/dependency/groovy'
require 'build/dependency/jboss_as'
require 'build/dependency/mariadb_jdbc'
require 'build/dependency/new_relic'
require 'build/dependency/openjdk/openjdk'
require 'build/dependency/play_jpa_plugin'
require 'build/dependency/postgresql_jdbc'
require 'build/dependency/redis_store'
require 'build/dependency/spring_boot_cli'
require 'build/dependency/tc_server'
require 'build/dependency/tomcat'
require 'build/dependency/tomcat_lifecycle_support'
require 'build/dependency/tomcat_logging_support'
require 'build/root'

describe Build::Root do
  include_context 'console_helper'

  let(:instance) { double('instance') }

  shared_examples 'dependency' do

    it 'should display error message if version is not specified' do
      Build::Root.start([dependency])

      expect(stderr.string).to match('--version')
    end

    it 'should not display error message if version is specified' do
      expect(type).to receive(:new).and_return(instance)
      expect(instance).to receive(:build)

      Build::Root.start([dependency, '--version', 'test-version'])
    end

  end

  shared_examples 'openjdk' do

    it 'should display error message if version is not specified' do
      Build::Root.start([dependency])

      expect(stderr.string).to match('--version')
    end

    it 'should display error message if build-number is not specified' do
      Build::Root.start([dependency])

      expect(stderr.string).to match('--build-number')
    end

    it 'should display error message if tag is not specified' do
      Build::Root.start([dependency])

      expect(stderr.string).to match('--tag')
    end

    it 'should not display error message if version, build-number, and tag are specified' do
      expect(type).to receive(:new).and_return(instance)
      expect(instance).to receive(:build)

      Build::Root.start([dependency, '--version', 'test-version', '--build-number', 'test-build-number',
                         '--tag', 'test-tag'])
    end

  end

  it 'should display error message if no dependency is specified' do
    Build::Root.start([])

    expect(stdout.string).to match('help \[COMMAND\]')
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'app-dynamics' }
      let(:type) { Build::Dependency::AppDynamics }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'auto-reconfiguration' }
      let(:type) { Build::Dependency::AutoReconfiguration }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'groovy' }
      let(:type) { Build::Dependency::Groovy }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'jboss-as' }
      let(:type) { Build::Dependency::JBossAS }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'mariadb-jdbc' }
      let(:type) { Build::Dependency::MariaDbJDBC }
    end
  end

  context do
    include_examples 'openjdk' do
      let(:dependency) { 'openjdk' }
      let(:type) { Build::Dependency::OpenJDK }
    end
  end

  context do
    include_examples 'openjdk' do
      let(:dependency) { 'openjdk-inner' }
      let(:type) { Build::Dependency::OpenJDKInner }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'new-relic' }
      let(:type) { Build::Dependency::NewRelic }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'play-jpa-plugin' }
      let(:type) { Build::Dependency::PlayJPAPlugin }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'postgresql-jdbc' }
      let(:type) { Build::Dependency::PostgreSQLJDBC }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'redis-store' }
      let(:type) { Build::Dependency::RedisStore }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'spring-boot-cli' }
      let(:type) { Build::Dependency::SpringBootCLI }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'tc-server' }
      let(:type) { Build::Dependency::TcServer }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'tomcat' }
      let(:type) { Build::Dependency::Tomcat }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'tomcat-lifecycle-support' }
      let(:type) { Build::Dependency::TomcatLifecycleSupport }
    end
  end

  context do
    include_examples 'dependency' do
      let(:dependency) { 'tomcat-logging-support' }
      let(:type) { Build::Dependency::TomcatLoggingSupport }
    end
  end

end
